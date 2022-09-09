import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:linea_profundizacion2/main.dart';
void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, home: registro());
  }
}

class registro extends StatefulWidget{
  @override
  registroapp createState()=> registroapp();

}
class registroapp extends State<registro> {
  TextEditingController usuario = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController email = TextEditingController();
  final firebase=FirebaseFirestore.instance;

  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(contrasena.text, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  registroUsuario() async{
    try{
      await  firebase.collection("Usuarios").doc().set(
          {
            "Nombre":usuario.text,
            "Telefono":telefono.text,
            "Contraseña":contrasena.text,
            "email":email.text,
            "Estado":true
          }
      );
      print('correcto');
    }catch(e){
      print("Error"+e.toString());
    }
  }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar:AppBar(
        backgroundColor: Colors.blue,
        title: Text("Registro usuario"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10,top: 50, right: 10),
                child: TextField(
                  controller: usuario,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.assignment_ind_outlined),
                      labelText: "Nombre de usuario",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite nombre de usuario",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: telefono,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_phone_outlined ),
                      labelText: "Telefono",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite su telefono",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_post_office_outlined ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite su Email",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: contrasena,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.https_rounded),
                      labelText: "Contraseña",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite su contraseña",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  obscureText: true,
                ),
              ),
              Padding(padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (){
                    registroUsuario();
                    usuario.clear();
                    telefono.clear();
                    contrasena.clear();
                    email.clear();
                    showDialog(
                        context: context,
                        builder: (context)=> AlertDialog(
                          title: Text("Registro"),
                          content: Text("El usuario a sido registrado con exito"),
                          actions: <Widget> [
                            FlatButton(
                              child: Text("Aceptar"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                    );
                  },
                  child: Text("Registrar"),
                ),
              )
            ],
          )),
    );
  }
}