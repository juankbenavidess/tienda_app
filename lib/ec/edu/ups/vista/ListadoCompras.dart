

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/modelo/FacturaCabecera.dart';
import 'package:tienda_app/ec/edu/ups/vista/carritoLista.dart';
import 'package:tienda_app/ec/edu/ups/vista/inicio.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart' as servicio;

String ipgeneral=servicio.ipServidor;

void main() => runApp(ListadoCompras());



Future<List<FacturaCabecera>>  listarCabeceras(String _urlServicio) async
{
  /**
   * Para mostrar consumir un post
   */
  print(_urlServicio+"__GET");
  final _url = "http://"+ipgeneral+":8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::0105007199::";
  final response = await http.get(_url);
  print( response.body);

  var carritos = new List<FacturaCabecera>();
  Iterable list = json.decode(response.body);
  carritos = list.map((model) => FacturaCabecera.fromJson(model)).toList();
  return carritos;
  // return carritoModeloToJson(response.body);
  /**
   * Para consumir un get obteniendo las compras de un usuario
   */

}

Future<String> obtener() async {//getPeliculaCedula
  final _url = "http://"+ipgeneral+":8080/ProyectoAppDis/srv/servicios/getCarritoXCedula?parametro=::0105007199:";
  final response = await http.get(_url);
  print("responsito "+response.request.toString());
  return response.body.toString();
}


Future<String>  comprar() async
{
  final _url = "http://"+ipgeneral+":8080/ProyectoAppDis/srv/servicios/realizarCompra";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":0105007199:Cuenca - Azuay:78584893498:"}';
  final response = await http.post(_url, headers: _headers , body : _body);
  print( response.body);
  return "ok";
}


class ListadoCompras extends StatelessWidget {

  /*UsuarioF usuariores;*/

  Carrito carritos;
  /*
  MostrarPeliculas({@required this.productRes, @required this.usuariores});
*/
  ListadoCompras({@required this.carritos});



  @override
  Widget build(BuildContext context) {
    listarCabeceras("");
    final appTitle = 'Carrito de Compras';
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

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
    print('llega al print carritp widget');
    var _menuEleccion = Drawer(
      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountName: Text("User Cliente"),
            accountEmail: Text("juancarlos.pelistore@gmail.com"),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://seeklogo.com/images/M/movie-time-cinema-logo-8B5BE91828-seeklogo.com.png",),

                  fit: BoxFit.cover),

            ),
          ),
          Ink(
            color: Colors.white,
            child: ListTile(
              title: Text("Ajustes"),
              onTap: () {

              },
            ),
          ),
          Ink(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Ver Compras Realizadas"),
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListadoCompras(),
                    //******************************************

                    //DetallesPro(productRes: listaPeliculas[index],),
                  ),
                );

              },
            ),
          ),
          Ink(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Carrito Compras"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => carritoLista(),
                    //******************************************

                    //DetallesPro(productRes: listaPeliculas[index],),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );

    print("antes de return widget");

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {

                  comprar();
                },
                child: Icon(
                  Icons.shop,
                  size: 26.0,
                ),

              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu(),
                      //******************************************

                      //DetallesPro(productRes: listaPeliculas[index],),
                    ),
                  );
                },
                child: Icon(
                  Icons.keyboard_return,
                  size: 26.0,
                ),

              )
          ),
        ],
      ),





      drawer: _menuEleccion,
      body: FutureBuilder<List<FacturaCabecera>>(
        future: listarCabeceras(""),
        builder: (context, snapshot) {
          print(obtener());
          return snapshot.hasData
              ? PhotosList(listaCarrito:  snapshot.data)
              : Center(child: CircularProgressIndicator());
        },


      ),


    );

  }
}

class PhotosList extends StatelessWidget {


  List<FacturaCabecera> listaCarrito;
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
                  backgroundImage: NetworkImage('https://image.shutterstock.com/image-vector/vector-logo-slate-board-shooting-260nw-279718811.jpg'),
                ),



                title: Text(listaCarrito[index].cedulaUsuario.toString()),
                subtitle: Text("\ Total \$ " + listaCarrito[index].total.toString()+"\                "
                    "                                       "
                    " Fecha:" +listaCarrito[index].fecha.toString()),
                onTap: () {


                },
              ),


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
