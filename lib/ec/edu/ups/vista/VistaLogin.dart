import 'package:flutter/material.dart';
import 'package:tienda_app/ec/edu/ups/vista/inicio.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaProducto.dart';
import 'package:tienda_app/ec/edu/ups/vista/VistaCrearUsuario.dart';



class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();

}



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



  @override
  Widget build(BuildContext context)
  {


    final logo = SizedBox(
      height: 200,

      child: Image.network('http://imgfz.com/i/4XWKr6E.png')
    );
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'juancarlos.pelistore@gmail.com',
      decoration: InputDecoration(

        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'Contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
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

         // getProductos();
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => productos2()));
        // Navigator.of(context).pushNamed(HomePage.tag)
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Registro_()));
          //  Navigator.of(context).pushNamed(HomePage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Registrarse', style: TextStyle(color: Colors.black)),
      ),
    );
    final forgotLabel = FlatButton(
      child: Text(
        'Olvide la contraseña',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
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
            forgotLabel
          ],
        ),
      ),
    );
  }
}