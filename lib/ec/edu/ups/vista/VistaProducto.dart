import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorRecursos.dart';

import 'package:tienda_app/ec/edu/ups/modelo/Pelicula.dart' as PeliculaModelo;
import 'package:tienda_app/ec/edu/ups/vista/VistaLogin.dart';
import 'package:tienda_app/ec/edu/ups/controlador/ControladorServicio.dart' as servicio;
import 'package:http/http.dart' as http;



/*
void main() {
  runApp(VistaProducto());
}
*/






/*
List<Pelicula> listCarrito = new List<Pelicula>();
*/







class VistaProducto extends StatelessWidget {


  PeliculaModelo.Pelicula  productRes;


   bool esvotado=false  ;

  VistaProducto({@required this.productRes, this.esvotado});





  @override
  Widget build(BuildContext context) {
    print('Mostrando  productos despues de hacer el login');


    Widget titleSection = Container(

      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    productRes.nombre,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Precio \$" + productRes.precio.toString(),

                ),
                //Text( "Editorial = " + productRes.editorial),
                Text( "Año = " + productRes.anio.toString()),

              ],
            ),
          ),
          /*3*/

          IconButton(
            icon: Icon(Icons.star
            ,
            color: esvotado?Colors.red:Colors.black,),
            tooltip: 'Dale al like :)',

            //aqui pilas para el like
            onPressed: () async {


              /**
               * aqui agregar el servicio
               */
             int _codigo =  productRes.codigoPelicula;
              String url = "http://" +
                  servicio.ipServidor +
                  ":8080/ProyectoAppDis/srv/servicios/getPelicula?id=::$_codigo:";
              final response = await http.get(url);
              var producto = new  PeliculaModelo.Pelicula();

              producto =    PeliculaModelo.Pelicula.fromJson(json.decode(response.body));
              this.productRes= producto;


              /**
               * ya termina el servicio
               */


cedula = "0105007199";
                  if(esvotado){
                    print("quitando voto");

                    /**
                     * aqui agrega el servicio
                     */
                   int  idPelicula = producto.codigoPelicula;
                    String _url =
                        "http://" + servicio.ipServidor + ":8080/ProyectoAppDis/srv/servicios/removeLike";
                    final _headers = {"Content-type": "application/json"};
                    var _body = '{ "parametro" : ":$cedula:$idPelicula:"}';
                    final response = await http.post(_url, headers: _headers, body: _body);
                    print("respuesta estado si tru o fals: "+response.body);

                    /**
                     * aqui termina servicio remov like
                     */
                    //ojo cambiar cedula
                    esvotado = false;
                   Navigator.of(context).pop(true);

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => VistaProducto(productRes: producto, esvotado: esvotado)));



                  }else{
                    print("dando voto");
                   //

                    int  idPelicula = producto.codigoPelicula;
                    String _url =
                        "http://" + servicio.ipServidor + ":8080/ProyectoAppDis/srv/servicios/addLike";
                    final _headers = {"Content-type": "application/json"};
                    var _body = '{ "parametro" : ":$cedula:$idPelicula:"}';
                    final response = await http.post(_url, headers: _headers, body: _body);

                    esvotado = true;
                   Navigator.of(context).pop(true);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => VistaProducto(productRes: producto, esvotado: esvotado)));

                  }
            },
            color  :    !esvotado  ? Colors.black:Colors.red,///cambiar cedula ojo
          ),
          Text(productRes.listaVoto.length.toString()),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColorDark;

    final buttonCompartir = Material(
      child: MaterialButton(
        child: _buildButtonColumn(color, Icons.share, 'Compartir'),
        onPressed: () async {
//final ByteData bytes = await rootBundle.load(productRes.urlImagen);
          // Share.file(productRes.nombre, productRes.descripcion, bytes.buffer.asUint8List(), 'image/jpg', text: 'My optional text.')
          Share.text(
              productRes.nombre,
              "Nombre: \n"
                  +productRes.nombre+
                  "Descripcion: \n" +
                  productRes.descripcion +
                  "\n\n PRECIO \$" +
                  productRes.precio.toString() +
                  "   \n\n" +
                  productRes.imagenHttp,
              'text/plain');
        },
      ),
    );

    Widget ico = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const <Widget>[

            /*Icon(
              Icons.audiotrack,
              color: Colors.green,
              size: 30.0,
            ),
            Icon(
              Icons.beach_access,
              color: Colors.blue,
              size: 36.0,
            ),*/
          ],
        )



    );

    Widget textSection2 = Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Descripcion" ,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),

      ),
    );


    Widget textSection = Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        productRes.descripcion,
        softWrap: true,
      ),
    );


    @override
    Widget build(BuildContext context) {
      return new Center(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                  servicio.addCarrito(productRes.codigoPelicula.toString(), "0105007199");
                mostrarMensaje("Producto añadido al carrito");
              },
              color: Colors.white,
              child: const Text(
                  'Anadir al carrito',
                  style: TextStyle(fontSize: 20)
              ),
            ),

          ],
        ),
      );
    }






    final ButtonComprar = Material(

      borderRadius: BorderRadius.circular(10.0),
      color: Colors.black,

      child: MaterialButton(
        onPressed: () {},
        child: Text("Comprar",

            textAlign: TextAlign.center,
             ),
      ),
    );
    return MaterialApp(
      title: 'Peliculas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pelicula Logueado'),
            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),

      ),
  ],

        ),
        body: ListView(
          children: [
            FadeInImage.assetNetwork(
              height: 400,

              placeholder: 'assets/loading.gif',
              image: productRes.imagenHttp,
              fit: BoxFit.cover,
            ),
            titleSection,
            ico,
            textSection2,
            textSection,
            build(context),
            buttonCompartir,


            //    ButtonComprar,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}