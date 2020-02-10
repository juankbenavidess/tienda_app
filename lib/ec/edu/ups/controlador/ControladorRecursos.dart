import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


String cedula ;
String tipo ;

void mostrarMensaje(String mensaje){
  Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0
  );
}








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




