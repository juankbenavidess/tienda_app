import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<String>  anadirCarrito(String _urlServicio,String _idPelicula,String _cedulaUsuario) async {
  /**
   * Para mostrar consumir un post
   */
  print(_urlServicio+"__"+_idPelicula+"___"+_cedulaUsuario);
  final _url = _urlServicio;
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$_idPelicula:$_cedulaUsuario:"}';
  final response = await http.post(_url, headers: _headers , body : _body);
  print( response.body);
  /**
   * Para consumir un get obteniendo las compras de un usuario
   */
  final response2 = await http.get("http://172.16.1.253:8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::$_cedulaUsuario:");

  print(response2.body);
}

class AnadirCarrito extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              RaisedButton(

                onPressed: () {
                  String url = "http://172.16.1.253:8080/ProyectoAppDis/srv/servicios/addCarrito";
                  String idPelicula = "1";
                  String cedulaUsuario = "0105007199";
                  print(anadirCarrito(url,idPelicula,cedulaUsuario));
                }

                ,
                color: Colors.blue,
                child: const Text(
                    'Probar POST',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              const SizedBox(height: 30),


            ],
          ),

        ),

      ),
    );
  }
}