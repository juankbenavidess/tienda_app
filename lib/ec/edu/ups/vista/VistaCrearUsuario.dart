import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:tienda_app/ec/edu/ups/controlador/ControladorRecursos.dart';
import 'package:tienda_app/ec/edu/ups/modelo/Usuarios.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import '../controlador/ControladorServicio.dart' as servicio;
import 'package:http/http.dart' as http;

/*
class VistaCrearUsuario extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(



      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Login'),

    );
  }
}
*/

class VistaCrearUsuario extends StatefulWidget {
  VistaCrearUsuario({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget>   createState() => new _VistaCrearUsuarioState();
}

class _VistaCrearUsuarioState extends State<VistaCrearUsuario> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  // final myController = TextEditingController();
  TextEditingController controllernombre = TextEditingController();
  TextEditingController controllerapellido = TextEditingController();
  TextEditingController controllercedula= TextEditingController();
  TextEditingController controllertelefono= TextEditingController();
  TextEditingController controllercorreo=TextEditingController();
  TextEditingController controllercontrasena=TextEditingController();
  TextEditingController controllerfecha=TextEditingController();
  TextEditingController controllerdireccion=TextEditingController();
  TextEditingController controllernickname=TextEditingController();

  int fechaMilis;




  @override
  Widget build(BuildContext context) {
    print("mostrando la centana para registrar usuario");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
      final nombreField = TextField(
      controller: controllernombre,
      obscureText: false,
        style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nombre",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );




    final cedulaFiel = TextField(
      controller: controllercedula,
      obscureText: false,
      style: style,
      maxLength: 10,
      showCursor: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Cedula",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );
    final telefonoField = TextField(
      controller: controllertelefono,
      obscureText: false,
      style: style,
      keyboardType: TextInputType.phone,
      maxLength: 13,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Telefono",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );


    final apellidoField = TextField(
      controller: controllerapellido,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Apellido",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );


    final emailField = TextField(
      controller: controllercorreo,
      obscureText: false,
      style: style,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Correo",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );

    final passwordField = TextField(
      controller: controllercontrasena,
      obscureText: true,
      style: style,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );





    final nicknamefield = TextField(
      controller: controllernickname,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nickname",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );


    final direccionfield= TextField(

      controller: controllerdireccion,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Direccion",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );

    final fechafield= TextField(
      controller: controllerfecha,
      obscureText: false,
      style: style,
      readOnly: true,
      onTap: (){

        DatePicker.showDatePicker(context,
            showTitleActions: true,
            theme: DatePickerTheme(
              containerHeight: 300.0,
              backgroundColor: 	Colors.cyan,
              cancelStyle :   TextStyle(
                  color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),

            ),

            onConfirm: (date) {

          String dia = date.day <10 ?"0"+date.day.toString():date.day.toString();
          String mes = date.month <10 ?"0"+date.month.toString():date.month.toString();
              controllerfecha.text= dia+"/"+mes+"/"+date.year.toString();

              fechaMilis = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;



            } );

      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Fecha Nacimiento",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(22.0))),
    );





    final resButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          


         final  _nombre=controllernombre.text.toString();
          final _apellido=controllerapellido.text.toString();
          final  _cedula=controllercedula.text.toString();
          final  _telefono=controllertelefono.text.toString();
          final  _email=controllercorreo.text.toString();
          final  _contrasenia=controllercontrasena.text.toString();
          final  _user=controllernickname.text.toString();
          final _direccionUsuario=controllerdireccion.text.toString();
          final  _fechaNacimiento=fechaMilis;
          final _fechaRegistro=0;
          final  _numeroCompra=0;
          final _dineroGastado=0;
          final _tipoUsuario='user';
         Usuario u = new Usuario(
             apellido: _apellido,
             cedula: _cedula,
         contrasenia: _contrasenia,
             dineroGastado: _dineroGastado,
             direccionUsuario: _direccionUsuario,
             email: _email,
             fechaNacimiento: _fechaNacimiento,
             fechaRegistro: _fechaRegistro,
             nombre: _nombre,
             numeroCompra: _numeroCompra,
             telefono: _telefono,
             tipoUsuario: _tipoUsuario,
             user: _user,
             listaCarrito: []
         );

         print(u.toJson());

         String url =
             "http://" + servicio.ipServidor + ":8080/ProyectoAppDis/srv/servicios/agregarUsuario";
         final _headers = {"Content-type": "application/json"};
         Map<String, dynamic> jsonBody = u.toJson();
         String _body = json.encode(jsonBody);

          http.Response response =  await http.post(url, headers: _headers, body: _body ,encoding: Encoding.getByName("utf8"))  ;

          String respuesta = response.body.toString();
          String mensaje = "";
          if(respuesta.contains("Error")){
            mensaje = "usuario ya creado";
          }else{
            if(!respuesta.contains("no")) {
              mostrarMensaje(respuesta);
              limpiarcampos();
              Navigator.of(context).pop(true);
            }else
              mensaje = "Ingrese los datos corrrectamente";
          }

          mostrarMensaje(mensaje) ;










          },
        child: Text("Registro",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

     return  new  WillPopScope(child: new Scaffold(
       body: SingleChildScrollView(

         child: Center(

           child: Container(
             color: Colors.white,
             child: Padding(
               padding: const EdgeInsets.all(36.0),
               child: Column(

                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   SizedBox(
                     height: 50,
                     child: Image.network("http://imgfz.com/i/4XWKr6E.png",
                       fit: BoxFit.contain,
                     ),
                   ),
                   SizedBox(height: 15.0),
                   nombreField,
                   SizedBox(height: 15.0),
                   apellidoField,
                   SizedBox(height: 15.0),
                   cedulaFiel,
                   SizedBox(height: 15.0),
                   nicknamefield,
                   SizedBox(height: 15.0),
                   emailField,
                   SizedBox(height: 25.0),
                   telefonoField,
                   SizedBox(height: 25.0),
                   direccionfield,
                   SizedBox(height: 15.0),
                   passwordField,
                   SizedBox(
                     height: 25.0,
                   ),
                   fechafield,
                   SizedBox(
                     height: 25.0,
                   ),

                   SizedBox(height: 15.0),
                   resButon,
                   SizedBox(
                     height: 15.0,
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
          );

  }





  void limpiarcampos(){
  String nada = "";
        controllerfecha.text = nada;
        controllerdireccion.text = nada;
        controllernickname.text = nada;
        controllercontrasena.text = nada;
        controllercorreo.text = nada;
        controllertelefono.text = nada;
        controllercedula.text = nada;
        controllernombre.text = nada;
        controllerapellido.text = nada;
  }

  /*
  Future<bool> _onBackPressed(BuildContext context) {
    print("hola back");
    Navigator.of(context).pop(true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));

    return Future.value(
        false);

  }
*/



}