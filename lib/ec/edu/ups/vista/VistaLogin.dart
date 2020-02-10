import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorRecursos.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorServicio.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProductos.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaCrearUsuario.dart';
import 'package:http/http.dart' as http;


String cedulaenlogin;
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();

}

//

class _LoginPageState extends State<LoginPage> {


  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

TextEditingController controllerusername = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();


  @override
  Widget build(BuildContext context)
  {

    print("Mostrando la ventana de login");
    final logo = SizedBox(
      height: 200,

      child: Image.network('http://imgfz.com/i/4XWKr6E.png')
    );
    final email = TextFormField(
controller: controllerusername,
      keyboardType: TextInputType.text,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Ingrese su usuario',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
     controller: controllerpassword,
     // initialValue: 'Contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Ingrese su contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async{




          String username = controllerusername.text.toString();
          String password = controllerpassword.text.toString();
          /**
           * Para mostrar consumir un post
           */
          String _url =
              "http://" + ipServidor + ":8080/ProyectoAppDis/srv/servicios/login";
          var _headers = {"Content-type": "application/json"};
          String  _body = '{ "parametro" : ":$username:$password:"}';
          http.Response  response =  await http.post(_url, headers: _headers, body: _body);
          //print(response.body);
          SharedPreferences sp = await SharedPreferences.getInstance();

          if(response.body.length>10){
            mostrarMensaje(response.body.toString());
            return ;
          }

          sp.setString("cedulalogin", response.body.toString());
          sp.setString("usernamelogin", username);

          cedulaenlogin = response.body.toString();
            //Navigator.pushAndRemoveUntil(context, VistaProductos(), VistaProductos());

         /* Navigator.of(context)
              .pushNamedAndRemoveUntil("/VistaProductos", (Route<dynamic> route) => false);
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => VistaProductos()));
*/

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              VistaProductos()), (Route<dynamic> route) => false);

        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Iniciar Sesion', style: TextStyle(color: Colors.black)),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {

          //return response.body.toString();
          Navigator.push(  context, MaterialPageRoute(builder: (context) => VistaCrearUsuario()));
          //  Navigator.of(context).pushNamed(HomePage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Registrarse', style: TextStyle(color: Colors.black)),
      ),
    );





    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerButton,

          ],
        ),
      ),
    );
  }



}