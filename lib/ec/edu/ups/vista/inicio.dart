

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/carritoLista.dart';
import 'package:tienda_app/ec/edu/ups/vista/ListadoCompras.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

//no login productos

void main() => runApp(Menu());

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Peliculas Inicial';
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
              title: Text("listado compras"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),

                ),
                );
              },
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
                  MaterialPageRoute(builder: (context) => LoginPage(),
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
                  MaterialPageRoute(builder: (context) => LoginPage(),
                    //******************************************

                    //DetallesPro(productRes: listaPeliculas[index],),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
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
                  backgroundImage: NetworkImage(listaPeliculas[index].imagenHttp.toString()),
                ),

                title: Text(listaPeliculas[index].nombre),
                subtitle: Text("\ Precio \$ " + listaPeliculas[index].precio.toString()+"\                "
                    "                                       "
                    " Año:" +listaPeliculas[index].anio.toString()),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VistaProductoNoLogin(productRes: listaPeliculas[index])

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


