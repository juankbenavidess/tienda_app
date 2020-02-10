

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';

import 'package:tienda_app/ec/edu/ups/controlador/ControladorServicio.dart' as servicio;
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductos.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

//no login productos

void main() => runApp(VistaProductosNoLogin());

class VistaProductosNoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Bienvenido a PeliStore';
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
print("mostrando todos los productos antes de hacer el login");

    var menuEleccion = Drawer(
      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountName: Text("User Cliente"),
            accountEmail: Text("peliStore@mail.com"
            ,style: TextStyle(color: Colors.black
              , fontSize: 20),),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://st3.depositphotos.com/15317184/31994/v/1600/depositphotos_319943942-stock-illustration-male-avatar-icon-suitable-for.jpg",),

                  fit: BoxFit.cover),

            ),
          ),
          Ink(
            color: Colors.white,

            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Iniciar Sesion"),
              onTap: () {
                //Navigator.of(context).pop(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),

                ),
                );
              },
            ),
          ),


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
                  //Navigator.of(context).pop(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),
                      //******************************************

                      //DetallesPro(productRes: listaPeliculas[index],),
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

        future: getPeliculas(),
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

    final fsp =   SharedPreferences.getInstance()  ;
    fsp.then((sp){
      String cedula = "";
      cedula = sp.getString("cedulalogin");
      if(cedula.length>=10){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            VistaProductos()), (Route<dynamic> route) => false);
      }
    });

    return GridView.builder(



      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10,

      ),
      itemCount: listaPeliculas.length,
      itemBuilder: (context, index) {

        return Card(

          color: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
          elevation: 10,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(listaPeliculas[index].imagenHttp.toString()),
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
                    producto =    Pelicula.fromJson(json.decode(response.body));
                    print(producto);



                  /**
                   * ya termina el servicio
                   */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>

                          VistaProductoNoLogin(productRes: producto)

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

                   onPressed: ()
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
                      }


                  ),

                ],
              )

            ],
          ),




        );
      },
    );

  }


}


