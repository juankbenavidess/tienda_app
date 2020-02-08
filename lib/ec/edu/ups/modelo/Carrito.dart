// To parse this JSON data, do
//
//     final carritoModelo = carritoModeloFromJson(jsonString);

import 'dart:convert';

List<Carrito> carritoFromJson(String str) => List<Carrito>.from(json.decode(str).map((x) => Carrito.fromJson(x)));

String carritoToJson(List<Carrito> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrito {
  int idCarrito;
  int cantidad;
  double totalCarrito;
  int fecha;
  Pelicula pelicula;
  String cedulaUsuario;

  Carrito({
    this.idCarrito,
    this.cantidad,
    this.totalCarrito,
    this.fecha,
    this.pelicula,
    this.cedulaUsuario,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) => Carrito(
    idCarrito: json["idCarrito"],
    cantidad: json["cantidad"],
    totalCarrito: json["totalCarrito"].toDouble(),
    fecha: json["fecha"],
    pelicula: Pelicula.fromJson(json["pelicula"]),
    cedulaUsuario: json["cedulaUsuario"],
  );

  Map<String, dynamic> toJson() => {
    "idCarrito": idCarrito,
    "cantidad": cantidad,
    "totalCarrito": totalCarrito,
    "fecha": fecha,
    "pelicula": pelicula.toJson(),
    "cedulaUsuario": cedulaUsuario,
  };
}

class Pelicula {
  int codigoPelicula;
  String nombre;
  String descripcion;
  double precio;
  int anio;
  int stock;
  int cantidadVotos;
  int cantidadVentas;
  String imagenHttp;
  int idCategoria;

  Pelicula({
    this.codigoPelicula,
    this.nombre,
    this.descripcion,
    this.precio,
    this.anio,
    this.stock,
    this.cantidadVotos,
    this.cantidadVentas,
    this.imagenHttp,
    this.idCategoria,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
    codigoPelicula: json["codigoPelicula"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    precio: json["precio"].toDouble(),
    anio: json["anio"],
    stock: json["stock"],
    cantidadVotos: json["cantidadVotos"],
    cantidadVentas: json["cantidadVentas"],
    imagenHttp: json["imagenHttp"],
    idCategoria: json["idCategoria"],
  );

  Map<String, dynamic> toJson() => {
    "codigoPelicula": codigoPelicula,
    "nombre": nombre,
    "descripcion": descripcion,
    "precio": precio,
    "anio": anio,
    "stock": stock,
    "cantidadVotos": cantidadVotos,
    "cantidadVentas": cantidadVentas,
    "imagenHttp": imagenHttp,
    "idCategoria": idCategoria,
  };
}
