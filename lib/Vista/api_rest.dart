import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart';

class rest extends StatefulWidget{
  @override
  restapp createState()=> restapp();

}
class restapp extends State<rest> {
  TextEditingController nombre = TextEditingController();
  TextEditingController pokedex = TextEditingController();
  TextEditingController generacion = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController poder = TextEditingController();
  var dataHttp='';

  consumirGet(var nombre) async {
    try {
      Response response =
      await get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/'+nombre));
      Map data = jsonDecode(response.body);
      //print('NAME: ${data['name']} /// username: ${data['username']}');
      // print(data);
      print(response.statusCode.toString() + " Código de respuesta");
      if (response.statusCode.toString() == '200') {
        pokedex.text = '${data['order']}';
        generacion.text='${data['generation']['name']} ';
        // correo.text='${data['email']}';
        // username.text='${data['username']}';

      }
    }catch(e){
      print(e.toString());
    }
  }


  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar:AppBar(
        backgroundColor: Color.fromRGBO(205, 16, 77, 10),
        title: Text("Consumo API POKEAPI"),
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset('imagenes/ope.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 50, right: 10),
                child: TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.assignment_ind_outlined),
                      labelText: "nombre del pokemon",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Digite el nombre del pokemon",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (){
                    consumirGet(nombre.text);
                    print('sirve');
                    print(nombre.text);
                  },
                  child: Text("Consultar"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(205, 16, 77, 10))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: pokedex,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_phone_outlined ),
                      labelText: "registro Pokedex No. ",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "registro Pokedex No. ",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: generacion,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.https_rounded),
                      labelText: "Pokemon de generacion ",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Pokemon de generacion ",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ],
          )),
    );
  }
}