import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linea_profundizacion2/models/employee.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';
import 'EditPage.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();
  //FirebaseFirestore.instance.collection('Employee').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data.docs.map((e) {
                  return Card(
                      child: Column(children: [
                        ListTile(
                          title: Text(e["Nombre"]+" "+e["Apellido"]),
                          subtitle: Container(
                            child: (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Correo: " + e['Correo'],
                                    style: const TextStyle(fontSize: 14)),
                                Text("Teléfono: " + e['Telefono'],
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            )),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => EditPage(
                                        employee: Employee(
                                            uid: e.id,
                                            nombre: e["Nombre"],
                                            apellido: e["Apellido"],
                                            correo: e["Correo"],
                                            telefono: e["Telefono"],
                                            rol: e["rol"],
                                            estado: e["Estado"]
                                        ),
                                      )));

                                }),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {

                  }),

                          ],
                        ),
                      ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}