import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controlador/ControladorServicio.dart' as servicio;


String ipgeneral=servicio.ipServidor;



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
                  String idPelicula = "1";
                  String cedulaUsuario = "0105007199";
                  print(servicio.addCarrito(idPelicula,cedulaUsuario));
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