

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/date_util.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductoNoLogin.dart';
import 'package:tienda_app/ec/edu/ups/modelo/FacturaCabecera.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaCarritoCompras.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductosNoLogin.dart';
//import 'package:tienda_app/VistaProductoNoLogin.dart';


import '../controlador/ControladorServicio.dart' as servicio;


/*
void main() => runApp(ListadoCompras());
*/


Future<List<FacturaCabecera>>  listarCabeceras(String _urlServicio) async
{
  /**
   * Para mostrar consumir un post
   */
  final _url = "http://"+ipgeneral+":8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::$cedulaenlogin::";
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
    final appTitle = 'Lista de Compras';
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


        ],
      ),

      body: FutureBuilder<List<FacturaCabecera>>(
        future: listarCabeceras(""),
        builder: (context, snapshot) {
         // print(obtener());
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

      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: listaCarrito.length,
      itemBuilder: (context, index) {

        return Card(
          color: Colors.white60,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
          elevation: 1,

          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://image.shutterstock.com/image-vector/invoice-bill-document-260nw-1102077059.jpg'),
                ),



                title: Text(listaCarrito[index].numeroFactura.toString(),
                style: TextStyle(fontSize: 20),),

                subtitle: Text("\ \nTotal \n\$" + listaCarrito[index].total.toStringAsPrecision(5)+"\                "
                    "                                       "
                    " Fecha:\n" + DateTime.fromMicrosecondsSinceEpoch(listaCarrito[index].fecha*1000).toString()),//listaCarrito[index].fecha.toString()),
                onTap: () {


                },
              ),


            ],
          ),




        );
      },
    );
  }
}
