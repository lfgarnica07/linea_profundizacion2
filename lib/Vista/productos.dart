
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linea_profundizacion2/Vista/photo.dart';

class productos extends StatefulWidget {
  @override
  productosapp createState() => productosapp();
}
class productosapp extends State<productos> {
  final firebase=FirebaseFirestore.instance;
  final CollectionReference _produccion= FirebaseFirestore.instance.collection('productos');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('inicio')),
      body: StreamBuilder(
        stream: _produccion.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder:(context,index ){
                final DocumentSnapshot documentSnapshot=
                streamSnapshot.data.docs[index];
                    return Card(
                        elevation: 4.0,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Image.network(documentSnapshot['url']),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Nombre: '+documentSnapshot['nombre'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      'Precio: '+documentSnapshot['precio'],
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
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                    );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize:MainAxisSize.max,
          children: [
            IconButton(
                icon:Icon(Icons.add_a_photo),
                iconSize: 40,
              color: Colors.white,
              onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return photo();
                  }));
              },
            )
          ],
        ),
      ),
    );
  }
}