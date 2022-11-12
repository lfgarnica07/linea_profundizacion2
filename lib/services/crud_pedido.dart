import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Pedidos');

class FirebaseCrud {

  static Future<Response> addPedido({
    String name,
    String position,
    String contactno,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Nombre": name,
      "Correo": position,
      "Telefono" : contactno
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }



  static Future<Response> updatePedido({
    String litros,
    String fecha,
    String latitud,
    String longitud,
    String estado,
    String docId,
    String idusuario,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "Litros": litros,
      "Fecha": fecha,
      "Latitud": latitud,
      "Longitud": longitud,
      "Estado":estado,
      "idUsuario":idusuario
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readPedido() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deletePedido({
    String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

}