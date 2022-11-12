import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linea_profundizacion2/Vista/Administrador/AdministrarUsuarios.dart';
import 'package:linea_profundizacion2/Vista/Administrador/Proveedores.dart';
import 'package:linea_profundizacion2/Vista/Geo.dart';
import 'package:linea_profundizacion2/Vista/maps.dart';
import 'package:linea_profundizacion2/Vista/photo.dart';
import 'package:linea_profundizacion2/pages/crear_productos.dart';
import 'package:linea_profundizacion2/models/productos_model.dart';
import 'package:linea_profundizacion2/pages/pedido_lista.dart';
import 'package:flutter/material.dart';
import 'package:linea_profundizacion2/services/firebase_services.dart';

void main() => runApp(invitado());
class invitado extends StatefulWidget {
  @override
  invitadoapp createState() => invitadoapp();
}

class invitadoapp extends State<invitado> {
  // This widget is the root of your application.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'App Compras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = List<ProductosModel>();

  List<ProductosModel> _listaCarro = [];

  FirebaseService db = new FirebaseService();

  StreamSubscription<QuerySnapshot> productSub;

  @override
  void initState() {
    super.initState();

    _productosModel = new List();

    productSub?.cancel();
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProductosModel> products = snapshot.docs
          .map((documentSnapshot) =>
          ProductosModel.fromMap(documentSnapshot.data()))
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
  }

  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 38,
                    ),
                    if (_listaCarro.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listaCarro.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (_listaCarro.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_listaCarro),
                      ),
                    );
                },
              ),
            ),

          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(left: 24, top: 48),
                          height: 150,
                          child: ListView.builder(
                            itemCount: _productosModel.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    height: 300,
                                    padding: new EdgeInsets.only(
                                        left: 10.0, bottom: 10.0),
                                    child: Card(
                                      elevation: 7.0,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24)),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CachedNetworkImage(
                                            imageUrl:
                                            '${_productosModel[index].image}' +
                                                '?alt=media',
                                            fit: BoxFit.cover,
                                            placeholder: (_, __) {
                                              return Center(
                                                  child: CupertinoActivityIndicator(
                                                    radius: 15,
                                                  ));
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(height: 3.0, color: Colors.grey),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        color: Colors.grey[300],
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemCount: _productosModel.length,
                          itemBuilder: (context, index) {
                            final String image = _productosModel[index].image;
                            var item = _productosModel[index];
                            return Card(
                                elevation: 4.0,
                                child: Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: CachedNetworkImage(
                                              imageUrl:
                                              '${_productosModel[index].image.toString()}',
                                              fit: BoxFit.cover,
                                              placeholder: (_, __) {
                                                return Center(
                                                    child:
                                                    CupertinoActivityIndicator(
                                                      radius: 15,
                                                    ));
                                              }),
                                        ),
                                        Text(
                                          '${_productosModel[index].name}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              '${_productosModel[index].price.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23.0,
                                                  color: Colors.black),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                                bottom: 8.0,
                                              ),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: GestureDetector(
                                                  child:
                                                  (!_listaCarro.contains(item))
                                                      ? Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.green,
                                                    size: 38,
                                                  )
                                                      : Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.red,
                                                    size: 38,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (!_listaCarro
                                                          .contains(item))
                                                        _listaCarro.add(item);
                                                      else
                                                        _listaCarro.remove(item);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          },
                        )),
                  ],
                ),
              )),
        ));
  }
}
