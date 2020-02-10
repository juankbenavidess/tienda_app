

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorRecursos.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductos.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductosNoLogin.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../modelo/Pelicula.dart';
import '../controlador/ControladorServicio.dart' as servicio;

/*
void main() => runApp(preCompra());
*/





class VistaPreCompra extends StatelessWidget {

  /*UsuarioF usuariores;*/

  Carrito carritos;
  /*
  MostrarPeliculas({@required this.productRes, @required this.usuariores});
*/
  VistaPreCompra({@required this.carritos});



  @override
  Widget build(BuildContext context) {
    servicio.getCarritoXCedula(cedula);
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


    print("antes de return widget");

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(

              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  double sumario =  0.0;


                  String _url =
                      "http://" + servicio.ipServidor + ":8080/ProyectoAppDis/srv/servicios/totalFactura";
                  final _headers = {"Content-type": "application/json"};
                  var _body = '{ "parametro" : ":$cedulaenlogin:"}';
                  http.Response response =   await http.post(_url, headers: _headers, body: _body);
                  print("respuesta estado si tru o fals: "+response.body);
                  sumario = double.parse(response.body) ;

                  // set up the buttons
                  Widget okbutton = FlatButton(

                    child: Text("COMPRAR"),
                    onPressed:   () async {
                    servicio.realizarCompra(cedulaenlogin, "en la casa del mijin ", "546547563434656").then((value){
                    mostrarMensaje(value);
                    if(value.contains("exitosamente"))
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        VistaProductos()), (Route<dynamic> route) => false);

                   // return;
                  }

                  );

                    },
                  );




                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(

                    title: Text("Generar Compra"),
                    content: Text("El total de su compra es de: $sumario"),
                    actions: [
                      okbutton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );

                //  Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

                print("llega al final");


//suma = 0;
//sumario = 0;
               //

                },
                child: Icon(
                  Icons.local_shipping,
                  size: 26.0,
                ),

              )
          ),

        ],
      ),




      body: FutureBuilder<List<Carrito>>(
future: servicio.getCarritoXCedula(cedulaenlogin), //ojo cambiar la cedula
        builder: (context, snapshot) {
  print(servicio.getCarritoXCedula(cedulaenlogin)); // ojo cambiar la cedula
          return snapshot.hasData
              ? PhotosList(listaCarrito: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },


      ),


    );

  }
}
double suma=0;
class PhotosList extends StatelessWidget {


   List<Carrito> listaCarrito;
  //final List<Peliculas> listaPeliculas;

  PhotosList({Key key, this.listaCarrito}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return GridView.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

      ),
      itemCount: listaCarrito.length,
      itemBuilder: (context, index) {

        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
          elevation: 10,
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



              ),
              const SizedBox(height: 30),
              TextField(

              ),
            ],
          ),




        );
      },
    );
  }






}
