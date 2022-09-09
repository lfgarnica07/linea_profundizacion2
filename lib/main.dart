import 'package:flutter/material.dart';
import 'Vista/Login.dart';
import 'Vista/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

class HomeStart extends State<Home> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bienvenidos',
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Boton Presionado');
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    child: Text('Entrar'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Boton Presionado');
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => registro()));
                    },
                    child: Text('Registrar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
