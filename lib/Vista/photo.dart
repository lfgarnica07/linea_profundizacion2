import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class photo extends StatefulWidget {
  @override
  photoapp createState() => photoapp();
}
class photoapp extends State<photo> {
  final firebase=FirebaseFirestore.instance;
  TextEditingController _nombre = TextEditingController();
  TextEditingController _precio= TextEditingController();
  File imagen;
  final forKey = GlobalKey<FormFieldState>();
  String url;

  Future capImagen() async {
    try{
      final imagen=await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagen==null)return;
      final tempImage= File(imagen.path);
      setState(()=>this.imagen=tempImage);
    }on PlatformException catch(e){
      print('error: $e');
    }
    Navigator.of(context).pop();
  }
  Future selImagen() async {
    try{
      final imagen=await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagen==null)return;
      final tempImage= File(imagen.path);
      setState(()=>this.imagen=tempImage);
    }on PlatformException catch(e){
      print('error: $e');
    }
    Navigator.of(context).pop();
  }
  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      capImagen();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child:Text('Tomar una foto', style: TextStyle(
                                fontSize: 16
                              ,),)
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      selImagen();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              child:Text('Seleccionar de galeria', style: TextStyle(
                                fontSize: 16
                                ,),)
                          ),
                          Icon(Icons.photo, color: Colors.blue)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child:Text('Cancelar', style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                                ,),textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir imagen'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    opciones(context);
                  },
                  child: Text('Seleccionar una imagen'),
                ),
                SizedBox(
                  height: 30,),
                imagen != null ?Image.file(imagen,width: 250,height: 250,):
                Text('no selecciono una imagen'), enable()
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Agregar imagen',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
  Widget enable() {
    return SingleChildScrollView(
        child: Container(
            child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: forKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            TextFormField(
                controller: _nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
                controller: _precio,
                decoration: InputDecoration(labelText: 'Precio'),
                ),
            RaisedButton(
              elevation: 10,
              child: Text('Agregar nuevo producto'),
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: status,
            )
          ],
        ),
      ),
    )));
  }
  registroProducto() async{
    try{
      await  firebase.collection("productos").doc().set(
          {
            "nombre":_nombre.text,
            "precio":_precio.text,
            "url":url,
          }
      );
      print('correcto');
    }catch(e){
      print("Error"+e.toString());
    }
  }
  void status() async{
    Reference reference = FirebaseStorage.instance.ref().child('Productos');
    var timekey=DateTime.now();
    TaskSnapshot storageTaskSnapshot =await reference.child(timekey.toString()+'.jpg').putFile(imagen);
    print(storageTaskSnapshot.ref.getDownloadURL());
    var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    url=dowUrl.toString();
    print(url);
    registroProducto();
    Navigator.pop(context);
  }
}
