// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  String cedula;
  String nombre;
  String apellido;
  String telefono;
  String email;
  int fechaNacimiento;
  int fechaRegistro;
  String user;
  String contrasenia;
  int numeroCompra;
  int dineroGastado;
  String direccionUsuario;
  String tipoUsuario;
  List<ListaCarrito> listaCarrito;

  Usuario({
    this.cedula,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.fechaNacimiento,
    this.fechaRegistro,
    this.user,
    this.contrasenia,
    this.numeroCompra,
    this.dineroGastado,
    this.direccionUsuario,
    this.tipoUsuario,
    this.listaCarrito,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    cedula: json["cedula"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    telefono: json["telefono"],
    email: json["email"],
    fechaNacimiento: json["fechaNacimiento"],
    fechaRegistro: json["fechaRegistro"],
    user: json["user"],
    contrasenia: json["contrasenia"],
    numeroCompra: json["numeroCompra"],
    dineroGastado: json["dineroGastado"],
    direccionUsuario: json["direccionUsuario"],
    tipoUsuario: json["tipoUsuario"],
    listaCarrito: List<ListaCarrito>.from(json["listaCarrito"].map((x) => ListaCarrito.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cedula": cedula,
    "nombre": nombre,
    "apellido": apellido,
    "telefono": telefono,
    "email": email,
    "fechaNacimiento": fechaNacimiento,
    "fechaRegistro": fechaRegistro,
    "user": user,
    "contrasenia": contrasenia,
    "numeroCompra": numeroCompra,
    "dineroGastado": dineroGastado,
    "direccionUsuario": direccionUsuario,
    "tipoUsuario": tipoUsuario,
    "listaCarrito": List<dynamic>.from(listaCarrito.map((x) => x.toJson())),
  };
}

class ListaCarrito {
  int idCarrito;
  int cantidad;
  double totalCarrito;
  int fecha;
  Pelicula pelicula;
  String cedulaUsuario;

  ListaCarrito({
    this.idCarrito,
    this.cantidad,
    this.totalCarrito,
    this.fecha,
    this.pelicula,
    this.cedulaUsuario,
  });

  factory ListaCarrito.fromJson(Map<String, dynamic> json) => ListaCarrito(
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
