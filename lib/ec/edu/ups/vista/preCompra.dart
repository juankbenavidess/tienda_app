

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/inicio.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart' as servicio;


void main() => runApp(preCompra());






class preCompra extends StatelessWidget {

  /*UsuarioF usuariores;*/

  Carrito carritos;
  /*
  MostrarPeliculas({@required this.productRes, @required this.usuariores});
*/
  preCompra({@required this.carritos});



  @override
  Widget build(BuildContext context) {
    servicio.getCarritoXCedula("0105007199");
    final appTitle = 'Pre Compra';
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
                  MaterialPageRoute(builder: (context) => preCompra(),
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

                servicio.realizarCompra("0105007199", "en la casa del mijin ", "546547563434656");
                },
                child: Icon(
                  Icons.local_shipping,
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
      body: FutureBuilder<List<Carrito>>(
future: servicio.getCarritoXCedula("0105007199"), //ojo cambiar la cedula
        builder: (context, snapshot) {
  print(servicio.getCarritoXCedula("0105007199")); // ojo cambiar la cedula
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

    double suma=0;
    return GridView.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: listaCarrito.length,
      itemBuilder: (context, index) {

        suma=suma+listaCarrito[index].totalCarrito.toDouble();
        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          elevation: 10,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://image.shutterstock.com/image-vector/vector-logo-slate-board-shooting-260nw-279718811.jpg'),
                ),




                title: Text(listaCarrito[index].pelicula.nombre.toString()),
                subtitle: Text("\ Total \$ " + listaCarrito[index].totalCarrito.toString()+"\                "
                    "                                       "
                    " Cantidad:" +listaCarrito[index].cantidad.toString()),


                //onTap: () {

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
               // },
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {},
                child: const Text('Realizar Compra', style: TextStyle(fontSize: 20)),
              ),
              /*Center(
                child: FadeInImage.assetNetwork(
                  height: 220,
                  placeholder: 'assets/loading.gif',
                  image: listaCarrito[index].pelicula.imagenHttp,
                ),
              ),*/
              /*ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Añadir al Carrito',
                      style: TextStyle(color: Colors.black),
                    ),



                    onPressed: () {


                      anadirCarrito("http://192.168.1.104:8080/ProyectoAppDis/srv/servicios/addCarrito", listaCarrito[index].pelicula.codigoPelicula.toString(), "0105007199");
                      //  Navigator.push(context,MaterialPageRoute(builder: (context) => DetallesPro()),);


                    },
                  ),


                ],
              )*/
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
