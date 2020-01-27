// To parse this JSON data, do
//
//     final usuarios = usuariosFromJson(jsonString);

import 'dart:convert';

List<Usuarios> usuariosFromJson(String str) => List<Usuarios>.from(json.decode(str).map((x) => Usuarios.fromJson(x)));

String usuariosToJson(List<Usuarios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuarios {
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
  double dineroGastado;
  String direccionUsuario;
  String tipoUsuario;
  List<ListaCarrito> listaCarrito;

  Usuarios({
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

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
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
    dineroGastado: json["dineroGastado"].toDouble(),
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
  int idPelicula;
  String cedulaUsuario;

  ListaCarrito({
    this.idCarrito,
    this.cantidad,
    this.totalCarrito,
    this.fecha,
    this.idPelicula,
    this.cedulaUsuario,
  });

  factory ListaCarrito.fromJson(Map<String, dynamic> json) => ListaCarrito(
    idCarrito: json["idCarrito"],
    cantidad: json["cantidad"],
    totalCarrito: json["totalCarrito"].toDouble(),
    fecha: json["fecha"],
    idPelicula: json["idPelicula"],
    cedulaUsuario: json["cedulaUsuario"],
  );

  Map<String, dynamic> toJson() => {
    "idCarrito": idCarrito,
    "cantidad": cantidad,
    "totalCarrito": totalCarrito,
    "fecha": fecha,
    "idPelicula": idPelicula,
    "cedulaUsuario": cedulaUsuario,
  };
}
