import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:linea_profundizacion2/DTO/ProduccionObj.dart';

class RegistrarUsuario extends StatefulWidget {
  @override
  //_RegisterPageState createState() => _RegisterPageState();
  RegistrarApp createState() => RegistrarApp();
}

class RegistrarApp extends State<RegistrarUsuario> {
  var lista=["Administrador","Empleado","Cliente"];
  String opciones="Seleccione una rol";

  bool loading=false;
  final formKey = GlobalKey<FormState>();
  String name = "";
  TextEditingController dateinput = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController rol = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  void insertDataUser() async {
    final plainText = pass.text;
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print(decrypted);
    print(encrypted.base64);

    try {
      CollectionReference ref = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot usuario = await ref.get();
      int contador = 0;
      for (var cursor in usuario.docs) {
        if (cursor.get('Correo') == correo.text) {
          contador=1;
        }
      }
      if(contador==0){
        await firebase.collection('Users').doc().set({
          'Nombre': nombre.text,
          'Apellido': apellido.text,
          'Telefono': telefono.text,
          'Correo': correo.text,
          'Contraseña': encrypted.base64,
          'Estado': "A",
          'rol': 'Invitado'
        });
        mensajeExito("Mensaje", "Registro exitoso");
        setState(() => loading=false);
        nombre.clear();
        apellido.clear();
        telefono.clear();
        correo.clear();
        pass.clear();


      }else{
        mensajeError("Mensaje", "Correo electrónico ya registrado");
        correo.clear();
        setState(() => loading=false);
      }

    } catch (e) {
      print('Error' + e.toString());
    }
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(

      appBar: AppBar(title: new Text("Registrar"),
        backgroundColor: Colors.green,),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('image/addUser.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 20, right: 21),
                child: TextFormField(
                  controller: nombre,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded,
                          color: Colors.green),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle:
                      const TextStyle(color: Colors.green),
                      labelText: 'Nombre(s)',
                      hintText: 'Digite su nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Ingrese un nombre correcto";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 10, right: 21),
                child: TextFormField(
                  cursorColor: Colors.green,
                  controller: apellido,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded,
                          color: Colors.green),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle:
                      const TextStyle(color: Colors.green),
                      labelText: 'Apellido(s)',
                      hintText: 'Digite sus apellidos',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "Ingrese un apellido correcto";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 10, right: 21),
                child: TextFormField(
                  cursorColor: Colors.green,
                  controller: telefono,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon:
                      Icon(Icons.phone_iphone, color: Colors.green),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle:
                      const TextStyle(color: Colors.green),
                      labelText: 'Teléfono',
                      hintText: 'Digite su número de teléfono',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                            .hasMatch(value)) {
                      return "Ingrese un numero de teléfono correcto";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 10, right: 21),
                child: TextFormField(
                  cursorColor: Colors.green,
                  controller: correo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.green),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle:
                      const TextStyle(color: Colors.green),
                      labelText: 'Correo electrónico',
                      hintText: 'Digite su correo electrónico',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                            .hasMatch(value)) {
                      return "Ingrese un correo electrónico correcto";
                    } else {
                      return null;
                    }
                  },
                ),
              ),Padding(
                padding: EdgeInsets.only(left: 26, top: 10, right: 21),
                child: TextFormField(
                  cursorColor: Colors.green,
                  controller: pass,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password, color: Colors.green),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      floatingLabelStyle:
                      const TextStyle(color: Colors.green),
                      labelText: 'Contraseña',
                      hintText: 'Digite su contraseña',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  validator: (value) {
                    if (value.isEmpty ||
                        !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return "Ingrese una contraseña correcta";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 40, right: 10, bottom: 20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      if (formKey.currentState.validate()) {
                        if(loading) return;
                        setState(() => loading=true);
                        await Future.delayed(Duration(seconds: 1));
                        insertDataUser();
                      }
                    },child: loading?
                  Row(
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      const SizedBox(width: 24),
                      Text('Por favor espere ...'),
                    ],
                  ) :Text('Registrar'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void mensajeError(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    child: Image.asset('image/warning.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    child: Text("Alerta",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
                      ),),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Center(
                    child: Text(mess),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child:
                      Text("Aceptar", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void mensajeExito(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    child: Image.asset('image/ok.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    child: Text("Exito",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
                      ),),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Center(
                    child: Text(mess),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child:
                      Text("Aceptar", style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
