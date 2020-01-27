// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Peliculas> listaPeliculas(String str) => List<Peliculas>.from(json.decode(str).map((x) => Peliculas.fromJson(x)));

String stringPeliculas(List<Peliculas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Peliculas {
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

  Peliculas({
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

  factory Peliculas.fromJson(Map<String, dynamic> json) => Peliculas(
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
