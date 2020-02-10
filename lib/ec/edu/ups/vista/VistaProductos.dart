

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProducto.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaCarritoCompras.dart';
import 'package:tienda_app/ec/edu/ups/vista/ListadoCompras.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorServicio.dart' as servicio;
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaProductosNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart' as servicio;

/*
void main() => runApp(VistaProductos());
*/
String _username ;
String _cedula ;

class VistaProductos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Future<SharedPreferences> sp =  SharedPreferences.getInstance();
    sp.then((value){
      _username = value.getString("usernamelogin");
      _cedula = value.getString("cedulalogin");
    });

    final appTitle = 'Peliculas';
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


    var menuEleccion = Drawer(
      child: ListView(

        children: <Widget>[

          UserAccountsDrawerHeader(

            onDetailsPressed: (){
              print ("toco toco");
            },
            accountName: Text("Bienvenido" , style: TextStyle(color: Colors.black),),//poner el nombre
            accountEmail: Text("$_username", style: TextStyle(color: Colors.black),),//poner el username
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://img2.freepng.es/20180626/fhs/kisspng-avatar-user-computer-icons-software-developer-5b327cc98b5780.5684824215300354015708.jpg",),

                  fit: BoxFit.cover),

            ),
          ),

          Ink(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(Icons.assignment),
              title: Text("Ver Compras Realizadas"),
              onTap: () {

                ///ver compras
                ///
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
                  MaterialPageRoute(builder: (context) => VistaCarritoCompras(_cedula),
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
              leading: Icon(Icons.close),
              title: Text("Cerrar Sesion"),
              onTap: () async{

                SharedPreferences sp = await SharedPreferences.getInstance();

                sp.clear();

                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    VistaProductosNoLogin()), (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(

        title: Text(title),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(

              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VistaCarritoCompras(_cedula),

                    ),
                  );
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 40.0,
                ),

              )
          ),
        ],
      ),


      drawer: menuEleccion,
      body: FutureBuilder<List<Pelicula>>(
        future: servicio.getPeliculas(),


        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? PhotosList(listaPeliculas: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },


      ),

    );
  }
}

class PhotosList extends StatelessWidget {



  final List<Pelicula> listaPeliculas;

  PhotosList({Key key, this.listaPeliculas}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return GridView.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: listaPeliculas.length,
      itemBuilder: (context, index) {
        print(listaPeliculas[index].nombre);

        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
          elevation: 20,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(listaPeliculas[index].imagenHttp),
                ),

                title: Text(listaPeliculas[index].nombre),
                subtitle: Text("\ Precio \$ " + listaPeliculas[index].precio.toString()+"\                "
                    "                                       "
                    " Año:" +listaPeliculas[index].anio.toString()),
                onTap: () async {
                  int idPelicula = listaPeliculas[index].codigoPelicula;
                  /**
                   * aqui agregar el servicio
                   */
                  String url = "http://" +
                      servicio.ipServidor +
                      ":8080/ProyectoAppDis/srv/servicios/getPelicula?id=::$idPelicula";
                  final response = await http.get(url);
                  var producto = new  Pelicula();
                  if (response.statusCode == 200) {

                    producto =    Pelicula.fromJson(json.decode(response.body));
                    print(producto);

                  } else {
                    throw Exception('Error Get Peliculas');
                  }

                  /**
                   * ya termina el servicio
                   */

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>

                            VistaProducto(productRes: producto, esvotado: true)

                    ),
                  );



                },
              ),
              Center(
                child: FadeInImage.assetNetwork(
                  height: 220,
                  placeholder: 'assets/loading.gif',
                  image: listaPeliculas[index].imagenHttp,
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Añadir al Carrito',
                      style: TextStyle(color: Colors.black),
                    ),



                    onPressed: () {

                      servicio.addCarrito(listaPeliculas[index].codigoPelicula.toString(), _cedula);

                      //  Navigator.push(context,MaterialPageRoute(builder: (context) => DetallesPro()),);


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
