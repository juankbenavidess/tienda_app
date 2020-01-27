import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_app/AnadirCarrito.dart';
import 'package:tienda_app/Peliculas.dart';



void main() {
  runApp(detallesPro());
}

Future<String>  anadirCarrito(String _urlServicio,String _idPelicula,String _cedulaUsuario) async
{
  /**
   * Para mostrar consumir un post
   */
  print(_urlServicio+"__"+_idPelicula+"___"+_cedulaUsuario);
  final _url = _urlServicio;
  final _headers = {"Content-type": "application/json"};
  var _body = '{ "parametro" : ":$_idPelicula:$_cedulaUsuario:"}';
  final response = await http.post(_url, headers: _headers , body : _body);
  print( response.body);
  /**
   * Para consumir un get obteniendo las compras de un usuario
   */
  final response2 = await http.get("http://172.16.1.253:8080/ProyectoAppDis/srv/servicios/getComprasXCedula?parametro=::$_cedulaUsuario:");

  print(response2.body);
}



final musicaReference = FirebaseDatabase.instance.reference().child("musica");
TextStyle style =
TextStyle(fontFamily: 'Montserrat', fontSize: 2.0, height: 12);

List<Peliculas> listCarrito = new List<Peliculas>();

class detallesPro extends StatelessWidget {

  /*UsuarioF usuariores;*/

  Peliculas productRes;
  /*
  MostrarPeliculas({@required this.productRes, @required this.usuariores});
*/
  detallesPro({@required this.productRes});

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++++++++++++");

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

          Icon(
            Icons.favorite_border,
            color: Colors.red[500],
          ),
          Text(productRes.cantidadVotos.toString()),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

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
            Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
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


    Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                String url = "http://172.16.1.253:8080/ProyectoAppDis/srv/servicios/addCarrito";
                String idPelicula = "1";
                String cedulaUsuario = "0105007199";
               anadirCarrito(url,idPelicula,cedulaUsuario);
              },
              color: Colors.white,
              child: const Text(
                  'Añadir al Carrito',
                  style: TextStyle(fontSize: 20)
              ),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {},
              color: Colors.white,
              child: const Text(
                  'Comprar',
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
            style: style.copyWith(
                fontSize: 20,
                color: Colors.white)),
      ),
    );
    return MaterialApp(
      title: 'Peliculas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Peliculas'),
            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {

              },
            child: Icon(
              Icons.shopping_cart,
              size: 26.0,
            ),
          )
      ),
  ],

        ),
        body: ListView(
          children: [
            FadeInImage.assetNetwork(
              height: 200,
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