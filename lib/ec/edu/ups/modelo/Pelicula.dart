// To parse this JSON data, do
//
//     final peliculas = peliculasFromJson(jsonString);

import 'dart:convert';

List<Pelicula> peliculaFromJson(String str) => List<Pelicula>.from(json.decode(str).map((x) => Pelicula.fromJson(x)));

String peliculaToJson(List<Pelicula> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  List<ListaVoto> listaVoto;

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
    this.listaVoto,
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
    listaVoto: List<ListaVoto>.from(json["listaVoto"].map((x) => ListaVoto.fromJson(x))),
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
    "listaVoto": List<dynamic>.from(listaVoto.map((x) => x.toJson())),
  };
}

class ListaVoto {
  int idVoto;
  String cedulaUsuario;
  int idPelicula;

  ListaVoto({
    this.idVoto,
    this.cedulaUsuario,
    this.idPelicula,
  });

  factory ListaVoto.fromJson(Map<String, dynamic> json) => ListaVoto(
    idVoto: json["idVoto"],
    cedulaUsuario: json["cedulaUsuario"],
    idPelicula: json["idPelicula"],
  );

  Map<String, dynamic> toJson() => {
    "idVoto": idVoto,
    "cedulaUsuario": cedulaUsuario,
    "idPelicula": idPelicula,
  };
}
