// To parse this JSON data, do
//
//     final fCabeceraModelo = fCabeceraModeloFromJson(jsonString);

import 'dart:convert';

List<FacturaCabecera> facturaCabeceraFromJson(String str) => List<FacturaCabecera>.from(json.decode(str).map((x) => FacturaCabecera.fromJson(x)));

String facturaCabeceraToJson(List<FacturaCabecera> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacturaCabecera {
  int numeroFactura;
  int fecha;
  double subtotal;
  double descuento;
  double iva;
  double total;
  String estado;
  String numeroTarjetaCredito;
  String direccionEnvio;
  String cedulaUsuario;
  List<ListaFacturaDetalle> listaFacturaDetalle;

  FacturaCabecera({
    this.numeroFactura,
    this.fecha,
    this.subtotal,
    this.descuento,
    this.iva,
    this.total,
    this.estado,
    this.numeroTarjetaCredito,
    this.direccionEnvio,
    this.cedulaUsuario,
    this.listaFacturaDetalle,
  });

  factory FacturaCabecera.fromJson(Map<String, dynamic> json) => FacturaCabecera(
    numeroFactura: json["numeroFactura"],
    fecha: json["fecha"],
    subtotal: json["subtotal"],
    descuento: json["descuento"],
    iva: json["iva"],
    total: json["total"].toDouble(),
    estado: json["estado"],
    numeroTarjetaCredito: json["numeroTarjetaCredito"],
    direccionEnvio: json["direccionEnvio"],
    cedulaUsuario: json["cedulaUsuario"],
    listaFacturaDetalle: List<ListaFacturaDetalle>.from(json["listaFacturaDetalle"].map((x) => ListaFacturaDetalle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "numeroFactura": numeroFactura,
    "fecha": fecha,
    "subtotal": subtotal,
    "descuento": descuento,
    "iva": iva,
    "total": total,
    "estado": estado,
    "numeroTarjetaCredito": numeroTarjetaCredito,
    "direccionEnvio": direccionEnvio,
    "cedulaUsuario": cedulaUsuario,
    "listaFacturaDetalle": List<dynamic>.from(listaFacturaDetalle.map((x) => x.toJson())),
  };
}

class ListaFacturaDetalle {
  int numFDetalle;
  int cantidad;
  double totalFDet;
  int numeroFactura;
  Pelicula pelicula;

  ListaFacturaDetalle({
    this.numFDetalle,
    this.cantidad,
    this.totalFDet,
    this.numeroFactura,
    this.pelicula,
  });

  factory ListaFacturaDetalle.fromJson(Map<String, dynamic> json) => ListaFacturaDetalle(
    numFDetalle: json["numFDetalle"],
    cantidad: json["cantidad"],
    totalFDet: json["totalFDet"].toDouble(),
    numeroFactura: json["numeroFactura"],
    pelicula: Pelicula.fromJson(json["pelicula"]),
  );

  Map<String, dynamic> toJson() => {
    "numFDetalle": numFDetalle,
    "cantidad": cantidad,
    "totalFDet": totalFDet,
    "numeroFactura": numeroFactura,
    "pelicula": pelicula.toJson(),
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
