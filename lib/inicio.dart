

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/DetallesPro.dart';
//import 'package:tienda_app/DetallesPro.dart';


import 'Peliculas.dart';
import 'Servicio.dart';


void main() => runApp(Menu());

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Productos';
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
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTck5juvjUIsqFYdvw96IhWY7h6_bh23LEGA7fLOhRbeCBoTeNKtA&s",),

                  fit: BoxFit.cover),

            ),
          ),
          Ink(
            color: Colors.black,
            child: ListTile(
              title: Text("Ajustes"),
              onTap: () {},
            ),
          ),
          Ink(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(Icons.table_chart),
              title: Text("Explorar"),
              onTap: () {},
            ),
          ),
          Ink(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Carrito Compras"),
              onTap: () {
                /* Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Carrito()));*/
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

      ),


      drawer: menuEleccion,
      body: FutureBuilder<List<Peliculas>>(
        future: getProductos(),


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


  final List<Peliculas> listaPeliculas;

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

        print("Entra");
        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
          elevation: 20,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/09/16/09/20/books-1673578_960_720.png'),
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
                          detallesPro(productRes: listaPeliculas[index])
                          //DetallesPro(productRes: listaPeliculas[index],),
                    ),
                  );


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


                      print('hola hola jjjj');
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
