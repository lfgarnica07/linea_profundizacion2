import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:linea_profundizacion2/Vista/Invitado/inicioInvitado.dart';
import 'package:linea_profundizacion2/Vista/RegistrarUsuario.dart';
import 'package:linea_profundizacion2/Vista/Vendedor/inicioVendedor.dart';
import 'menu.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:linea_profundizacion2/DTO/user.dart';
import 'package:linea_profundizacion2/Vista/Administrador/inicioAdmin.dart';

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
  final LocalAuthentication auth = LocalAuthentication();
  get passE => encriptarDatos(password.text);
  bool huella  = true;

  final key = encrypt.Key.fromSecureRandom(32);
  final iv = encrypt.IV.fromSecureRandom(16);
  get encrypter => encrypt.Encrypter(encrypt.AES(key));

  encriptarDatos(text){
    final encriptar = encrypter.encrypt(text, iv: iv);
    return encriptar.base16;
  }
  validarDatos() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot Usuario = await ref.get();
      if (Usuario.docs.length != 0) {
        for (var cursor in Usuario.docs) {
          if (email.text == cursor.get('Correo')) {
            print("Correo");
            print(passE);
            if ( password.text == cursor.get('Contraseña')) {
              print("contrasena");
              //print('Usuario encontrado');
              user userOb= user();
              userOb.correo=cursor.get('Correo');
              userOb.nombre=cursor.get('Nombre');
              if(cursor.get('rol')=='Admin'){
                Navigator.push(context, MaterialPageRoute(builder: (_) => tienda()));
              }else if(cursor.get('rol')=='Vendedor'){
                Navigator.push(context, MaterialPageRoute(builder: (_) => vendedor()));
              }else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => invitado()));
              }
            }
          }
        }
      }
    } catch (e) {
      print('ERROR-> ' + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(205, 16, 77, 10),
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
            color: Colors.white70,
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
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(205, 16, 77, 10))
                  ),
                  onPressed: (){
                    if (huella){
                      validarDatos();
                    }
                  },
                ) ,
              ),
              SizedBox(height: 10),
              Container(
                child: ElevatedButton(
                  child: Text("¿Nuevo Usuario? crea una cuenta"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(205, 16, 77, 10))
                  ),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>RegistrarUsuario()));
                  },
                ) ,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 50),
                    primary: Colors.black45,
                  ),
                  onPressed: () async {
                    print("Acceso aceptado");
                     bool isSuccess = await biometrico();
                    print('success ' + isSuccess.toString());
                    if (isSuccess){
                      huella = true;
                    }
                  },
                  child: Icon(Icons.fingerprint, size: 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> biometrico() async {
    //print("biométrico");

    bool flag = true;
    bool authenticated = false;
    if (flag) {
      const androidString = const AndroidAuthMessages(
        cancelButton: "Cancelar",
        goToSettingsButton: "Ajustes",
        signInTitle: "Ingrese",
        goToSettingsDescription: "Confirme su huella",
        biometricHint: "Toque el sensor",
        biometricNotRecognized: "Huella no reconocida",
        biometricRequiredTitle: "Required Title",
        biometricSuccess: "Huella reconocida",
      );
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();
      List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      print(canCheckBiometrics); //Returns trueB
      print("support -->" + isBiometricSupported.toString());
      print(
          availableBiometrics.toString()); //Returns [BiometricType.fingerprint]
      try {
        authenticated = await auth.authenticate(
            localizedReason: "Autentíquese para acceder",
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
            androidAuthStrings: androidString);
        if (!authenticated) {
          authenticated = false;
        }
      } on PlatformException catch (e) {
        print(e);
      }
      /* if (!mounted) {
        return;
      }*/

    }
    return authenticated;
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
                  user userOb= user();
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> menu(userOb)));
                },
                child:
                Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),

              )
            ],
          );
        });
  }
}

