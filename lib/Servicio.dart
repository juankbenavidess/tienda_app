import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_app/Peliculas.dart';

String ip="172.16.1.253/";
String urlser="http://"+ip+":8080/ProyectoAppDis/srv/services/getPeliculas";
bool bandera = false;
Future<List<Peliculas>> getProductos() async {
  print(urlser);
  final response = await http.get("http://"+ip+":8080/ProyectoAppDis/srv/servicios/getPeliculas");
  var producto = new List<Peliculas>();
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    producto = list.map((model) => Peliculas.fromJson(model)).toList();
    print(producto);
    return producto;
  } else {
    throw Exception('Error Get Musica');
  }
}

