import 'package:flutter/material.dart';
import 'package:linea_profundizacion2/Vista/RegistrarUsuario.dart';
import 'package:linea_profundizacion2/Vista/api_rest.dart';
import 'package:linea_profundizacion2/Vista/productos.dart';
import 'package:linea_profundizacion2/carrito/carrito.dart';
import 'package:provider/provider.dart';
import 'Vista/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create:(context)=>carrito(),
      child: MyApp(),
    ));
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
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Color.fromRGBO(205, 16, 77, 10),
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(205, 16, 77, 10))
                    ),
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
                          context, MaterialPageRoute(builder: (_) => RegistrarUsuario()));
                    },
                    child: Text('Registrar'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(205, 16, 77, 10))
                    ),
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
