import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_app/ec/edu/ups/modelo/Carrito.dart';
import 'package:tienda_app/ec/edu/ups/modelo/FacturaCabecera.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Pelicula.dart' as PeliculaModelo;
import 'package:tienda_app/ec/edu/ups/modelo/Usuarios.dart';

String ipServidor = "192.168.1.104";

Future<String> realizarCompra(  String cedula, String direccionEnvio, String numeroTarjeta) async {
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/realizarCompra";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$cedula:$direccionEnvio:$numeroTarjeta:"}';
  final response = await http.post(url, headers: _headers, body: _body);
  print(response.body);
  return "ok";
}

Future<String> addCarrito(String _idPelicula, String _cedulaUsuario) async {
  /**
   * Para mostrar consumir un post
   */
  String url =
      "http://" + ipServidor + ":8080/ProyectoAppDis/srv/servicios/addCarrito";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$_idPelicula:$_cedulaUsuario:"}';
  final response = await http.post(url, headers: _headers, body: _body);
  print(response.body);
}

Future<String> removeCarrito(String _idPelicula, String _cedulaUsuario) async {
  /**
   * Para mostrar consumir un post
   */
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/removeCarrito";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$_idPelicula:$_cedulaUsuario:"}';
  final response = await http.post(url, headers: _headers, body: _body);
  print(response.body);
}

Future<String> reduceCarrito(String _idPelicula, String _cedulaUsuario) async {
  /**
   * Para mostrar consumir un post
   */
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/reduceCarrito";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$_idPelicula:$_cedulaUsuario:"}';
  final response = await http.post(url, headers: _headers, body: _body);
  print(response.body);
}



Future<List<Carrito>> getCarritoXCedula(String cedula) async {
  /**
   * Para mostrar consumir un post
   */
  final _url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/getCarritoXCedula?parametro=::$cedula:";
  final response = await http.get(_url);
  print(response.body);

  var carritos = new List<Carrito>();
  Iterable list = json.decode(response.body);
  carritos = list.map((model) => Carrito.fromJson(model)).toList();
  return carritos;
}

Future<String> anularFactura(int numeroFactura) async {
  /**
   * Para mostrar consumir un post
   */
  String url = "http://" + ipServidor + ":8080/ProyectoAppDis/srv/servicios/reduceCarrito";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$numeroFactura:"}';
  final response = await http.post(url, headers: _headers, body: _body);
  print(response.body);
  return response.body.toString();
}

Future<String> login(String username, String password) async {
  /**
   * Para mostrar consumir un post
   */
  final _url =
      "http://" + ipServidor + ":8080/ProyectoAppDis/srv/servicios/login";
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$username:$password:"}';
  final response = await http.post(_url, headers: _headers, body: _body);
  print(response.body);
  return response.body.toString();
}




Future<List<FacturaCabecera>> getComprasXCedula(String cedula) async {
  /**
   * Para mostrar consumir un post
   */
  final _url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::$cedula:";
  final response = await http.get(_url);
  print(response.body);

  var compras = new List<FacturaCabecera>();
  Iterable list = json.decode(response.body);
  compras = list.map((model) => FacturaCabecera.fromJson(model)).toList();
  return compras;
}


Future<List<PeliculaModelo.Pelicula>> getPeliculas() async {
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/getPeliculas";
  final response = await http.get(url);
  var productos = new List<PeliculaModelo.Pelicula>();
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    productos =
        list.map((model) => PeliculaModelo.Pelicula.fromJson(model)).toList();
    print(productos);
    return productos;
  } else {
    throw Exception('Error Get Peliculas');
  }
}

Future<List<Usuario>> getUsuarios() async {
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/getUsuarios";
  final response = await http.get(url);
  var usuarios = new List<Usuario>();
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    usuarios =
        list.map((model) => Usuario.fromJson(model)).toList();
    print(usuarios);
    return usuarios;
  } else {
    throw Exception('Error Get Peliculas');
  }
}





Future<PeliculaModelo.Pelicula> getPelicula(int idPelicula) async {
  String url = "http://" +
      ipServidor +
      ":8080/ProyectoAppDis/srv/servicios/getPeliculas?id=::$idPelicula";
  final response = await http.get(url);
  var producto = new  PeliculaModelo.Pelicula();
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    producto =    PeliculaModelo.Pelicula.fromJson(list.first);
    print(producto);
    return producto;
  } else {
    throw Exception('Error Get Peliculas');
  }
}






/*
  Para consumir un get obteniendo las compras de un usuario

final response2 = await http.get("http://"+ipServidor+":8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::$_cedulaUsuario:");

print(response2.body);
 */
