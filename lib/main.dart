import 'package:flutter/material.dart';
import 'package:tienda_app/home.dart';
import 'package:tienda_app/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
     home: LoginPage(),
      /*home: home(),

       */
      routes: routes,
    );
  }
}