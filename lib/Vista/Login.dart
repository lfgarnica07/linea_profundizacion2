import 'package:cloud_firestore/cloud_firestore.dart';

import 'Registro.dart';
import 'package:flutter/material.dart';
void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
class Login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  validarDatos() async{
    try{
      CollectionReference ref= FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot Usuario= await ref.get();
      if(Usuario.docs.length !=0){
        for(var cursor in Usuario.docs) {
          print(cursor.get('email')+'+++++++++++ '+email.text);
          if (cursor.get("email") == email.text) {
            print("Usuario encontrados");
            print(cursor.get("Telefono"));
            if (cursor.get("Contraseña") == password.text) {
              print("Acceso aceptado");
              print("estado"+cursor.get("Nombre"));
              mensajeGeneral( 'Encontrado','acceso aceptado' );
            }
          }
        }
      }else {
        print("No se encuentra registrado");
      }
    }catch(e){
      print("Error...."+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20.0,
                  spreadRadius:5.0,
                  offset: Offset(
                      5.0,5.0
                  )
              )
            ],
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.only(top: 50,left: 20, right: 20, bottom: 50 ),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("imagenes/login.png",height: 120, ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_post_office_outlined ),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.https_rounded),
                  hintText: "Contraseña",
                  hintStyle: TextStyle(color: Colors.white),

                ),
                obscureText: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 70 ),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ElevatedButton(
                  child: Text("Login", style: TextStyle(color: Colors.white,fontSize: 20),),
                  onPressed: (){
                    print(email.text);
                    print(password.text);
                    print("presionado");
                    validarDatos();
                    //email.clear();
                    // password.clear();
                  },
                ) ,
              ),
              SizedBox(height: 10),
              Container(
                child: ElevatedButton(
                  child: Text("¿Nuevo Usuario? crea una cuenta"),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>registro()));
                  },
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void mensajeGeneral(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child:
                Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }
}

