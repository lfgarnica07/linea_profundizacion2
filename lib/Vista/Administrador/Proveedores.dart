import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Proveedores extends StatefulWidget {
  @override
  WebService createState() => WebService();
}

class WebService extends State<Proveedores> {

  TextEditingController id = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController email = TextEditingController();
  var dataHttp='';


  consumirGet(String id) async {
    try {
      Response response =
      await get(Uri.parse('http://parkingjmd123.000webhostapp.com/?id='+id));
      Map data = jsonDecode(response.body);
      //print(data);
      //print(response.statusCode.toString() + " Código de respuesta");
      if (response.statusCode.toString() == '200') {
        nombre.text = '${data['0']['nombre']}';
        telefono.text = '${data['0']['telefono']}';
        email.text = '${data['0']['email']}';
      }
    }catch(e){
      print('ERROR: '+e.toString());
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1.0),
      appBar: AppBar(
        title: Text('Proveedores'),
        backgroundColor: const Color.fromRGBO(40, 75, 99, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15,bottom: 8),
              child: const Text(
                'Buscar Proveedor',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(40, 75, 99, 1.0)
                ),
              ),
            ),

            Container(padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: id,
                decoration: InputDecoration(
                  labelText: 'ID',
                  hintText: 'Id del proveedor',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.perm_identity_outlined, color: Color.fromRGBO(60, 110, 113, 1.0)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1.0)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () {
                    //print(_from+' '+_to);
                    consumirGet(id.text);
                  },
                  child: Text('Buscar',style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                      shadowColor: const Color.fromRGBO(60, 110, 113, 1.0),
                      elevation: 15,
                      minimumSize: Size(150, 40)
                  )
              ),
            ),

            Container(padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.person_pin_outlined, color: Color.fromRGBO(60, 110, 113, 1.0)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1.0)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),

            Container(padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: TextField(
                controller: telefono,
                decoration: InputDecoration(
                  labelText: 'Telefono',
                  hintText: 'Telefono',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.phone, color: Color.fromRGBO(60, 110, 113, 1.0)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1.0)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),

            Container(padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.email, color: Color.fromRGBO(60, 110, 113, 1.0)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1.0)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}