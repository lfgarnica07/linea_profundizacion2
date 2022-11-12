import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Proveedores.dart';

class InicioAdmin extends StatefulWidget {
  @override
  PlantillaApp createState() => PlantillaApp();
}

class PlantillaApp extends State<InicioAdmin> {

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2),
                child: Center(
                    child: Text("Asovapp",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))),
              ),
              new UserAccountsDrawerHeader(
                accountName: Text(''),
                accountEmail: Text("",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('image/verde.png'), fit: BoxFit.cover),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Ink(
                    color: Colors.green,
                    child: new ListTile(
                      leading: Icon(
                        Icons.content_paste_search_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Administrar Usuarios",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Ink(
                    color: Colors.green,
                    child: new ListTile(
                      leading: Icon(
                        Icons.app_registration_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Productos",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {

                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Ink(
                    color: Colors.green,
                    child: new ListTile(
                      leading: Icon(
                        Icons.add_location_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Proveedores",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Proveedores()));
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Ink(
                    color: Colors.green,
                    child: new ListTile(
                      leading: Icon(
                        Icons.exit_to_app_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Cerrar sesion",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onTap: () {

                      },
                    ),
                  )),
            ],
          )),
      appBar: AppBar(
        title: Text('Ingrese Login'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Container(
                  width: 130,
                  height: 130,
                  child: Image.asset('images/user2.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}