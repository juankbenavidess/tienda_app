

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorRecursos.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductosNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaPrecompra.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';

import '../controlador/ControladorServicio.dart' as servicio;
import '../modelo/Pelicula.dart';

/*
void main() => runApp(VistaCarritoCompras());
*/

String _username ;


String ipgeneral=servicio.ipServidor;



Future<List<Carrito>>  listarCarritos(String _urlServicio) async
{


  /**
   * Para mostrar consumir un post
   */
  print(_urlServicio+"__GET");
  final _url = "http://"+servicio.ipServidor+":8080/ProyectoAppDis/srv/servicios/getCarritoXCedula?parametro=::$cedulaenlogin:";
  print("url a pedir: "+_url);
  final response = await http.get(_url);
  print( response.body);

  var carritos = new List<Carrito>();
    Iterable list = json.decode(response.body);
    carritos = list.map((model) => Carrito.fromJson(model)).toList();
    return carritos;
 // return carritoModeloToJson(response.body);
  /**
   * Para consumir un get obteniendo las compras de un usuario
   */

}






class VistaCarritoCompras extends StatelessWidget {

  /*UsuarioF usuariores;*/

  Carrito carritos;

String cedulalogin;

  VistaCarritoCompras(@required this.cedulalogin,{@required this.carritos});



  @override
  Widget build(BuildContext context) {
  // listarCarritos("");


    final appTitle = 'Carrito de Compras';
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}
bool numeroregistros ;
class MyHomePage extends StatelessWidget {
  final String title;
  final String text1;


  MyHomePage(
      {
        Key key,
        this.title,
        this.text1
      }
      ) : super(key: key);



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if(!numeroregistros){
                    mostrarMensaje("no tiene productos agregados al carrito");
                    return;
                  }
                //comprar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VistaPreCompra(),
                      //******************************************

                      //DetallesPro(productRes: listaPeliculas[index],),
                    ),
                  );


                },
                child: Icon(
                  Icons.shop,
                  size: 26.0,
                ),

              )
          ),

        ],
      ),

      body: FutureBuilder<List<Carrito>>(
future: servicio.getCarritoXCedula(cedulaenlogin) ,//ojo cambiar la ccedula
        builder: (context, snapshot) {
          numeroregistros = snapshot.hasData;
          return snapshot.hasData
              ? PhotosList(listaCarrito: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },


      ),


    );

  }
}

class PhotosList extends StatelessWidget {


   List<Carrito> listaCarrito;
  //final List<Peliculas> listaPeliculas;

  PhotosList({Key key, this.listaCarrito}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GridView.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: listaCarrito.length,
      itemBuilder: (context, index) {

        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
          elevation: 20,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(listaCarrito[index].pelicula.imagenHttp),
                ),



                title: Text(listaCarrito[index].pelicula.nombre.toString()),
                subtitle: Text("\ Total \$ " + listaCarrito[index].totalCarrito.toString()+"\                "
                    "                                       "
                    " Cantidad:" +listaCarrito[index].cantidad.toString()),
                onTap: () {

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          detallesPro(productRes: listaPeliculas[index])
                          //DetallesPro(productRes: listaPeliculas[index],),
                    ),
                  );*/


                  /*
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DetallesPro()),
                  );

                   */
                },
              ),
              Center(
                child: FadeInImage.assetNetwork(
                  height: 220,
                  placeholder: 'assets/loading.gif',
                  image: listaCarrito[index].pelicula.imagenHttp,
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Añadir ',
                      style: TextStyle(color: Colors.black),
                    ),



                    onPressed: () async {
                       servicio.addCarrito(listaCarrito[index].pelicula.codigoPelicula.toString(),listaCarrito[index].cedulaUsuario).then((value){
                         mostrarMensaje("se agrego + 1");
                         Navigator.of(context).pop(true);
                         Navigator.push(
                             context, MaterialPageRoute(builder: (context) => VistaCarritoCompras(listaCarrito[index].cedulaUsuario)));
                       });
                    },
                  ),
                  FlatButton(
                    child: const Text('Restar ',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {

                      servicio.reduceCarrito(listaCarrito[index].pelicula.codigoPelicula.toString(), listaCarrito[index].cedulaUsuario).then((value){
                        mostrarMensaje("se resto - 1");
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => VistaCarritoCompras(listaCarrito[index].cedulaUsuario)));
                      });
                    },
                  ),
                  FlatButton(
                    child: const Text('Eliminar de Carrito',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {

                      servicio.removeCarrito(listaCarrito[index].pelicula.codigoPelicula.toString(), listaCarrito[index].cedulaUsuario).then((value){
                        mostrarMensaje("se agrego + 1");
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => VistaCarritoCompras(listaCarrito[index].cedulaUsuario)));

                      });
                    },
                  ),


                ],
              )
             /* ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[

                    FlatButton(
                      child: const Text('Añadir al Carrito',
                        style: TextStyle(color: Colors.black),
                      ),



                      onPressed: () {

                      //  Navigator.push(context,MaterialPageRoute(builder: (context) => DetallesPro()),);


                      },
                    ),
                  ],
                ),
              ),*///hol
            ],
          ),




        );
      },
    );
  }
}
