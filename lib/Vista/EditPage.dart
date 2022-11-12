import 'dart:core';
import 'package:linea_profundizacion2/Vista/listpage.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../services/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Employee employee;
  EditPage({this.employee});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  var lista=["Activo","Inactivo"];
  String opciones="Seleccione una estado";

  bool loading=false;
  final _docid = TextEditingController();
  final _nombre_comprador = TextEditingController();
  final _apellido_comprador = TextEditingController();
  final _correo_comprador = TextEditingController();
  final _telefono_comprador = TextEditingController();
  final _rol_comprador = TextEditingController();
  final _estado_comprador = TextEditingController();
  String selecciondropdown="";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.employee.uid.toString());
    _nombre_comprador.value = TextEditingValue(text: widget.employee.nombre.toString());
    _apellido_comprador.value = TextEditingValue(text: widget.employee.apellido.toString());
    _correo_comprador.value = TextEditingValue(text: widget.employee.correo.toString());
    _telefono_comprador.value = TextEditingValue(text: widget.employee.telefono.toString());
    _rol_comprador.value = TextEditingValue(text: widget.employee.rol.toString());
    _estado_comprador.value = TextEditingValue(text: widget.employee.estado.toString());
    //selecciondropdown=TextEditingValue(text: widget.employee!.estado.toString()) as String;

  }

  @override
  Widget build(BuildContext context) {


    final DocIDField = TextField(
        controller: _docid,
        autofocus: false,
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));

    final nombreField = TextField(
        controller: _nombre_comprador,
        autofocus: false,
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));


    final apellidoField = TextFormField(
        controller: _apellido_comprador,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es requerido';
          }
        },
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
            labelText: 'Apellido',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));
    final correoField = TextFormField(
        controller: _correo_comprador,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es requerido';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email,
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
            labelText: 'Correo',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));
    final telefonoField = TextFormField(
        controller: _telefono_comprador,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es requerido';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone,
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
            labelText: 'Teléfono',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));

    final rolField = TextFormField(
        controller: _rol_comprador,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es requerido';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.supervised_user_circle_sharp,
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
            labelText: 'Rol',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));
    final estadoField = TextFormField(
        controller: _estado_comprador,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo es requerido';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.verified_user,
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
            labelText: 'Estado',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
                (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List of Employee'));

    final dropdown= Padding(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0),

        child: DropdownButtonFormField(validator: (value) {
          if (value == null) {
            return 'Este campo es requerido';
          }
        }, items: lista.map((String a) {
      return DropdownMenuItem(value: a, child: Text(a));
    }).toList(),
      onChanged: (_value)=>{
        setState((){
          opciones=_value as String;
        })
      },
      hint: Text(opciones),
          decoration: InputDecoration(
              prefixIcon:
              Icon(Icons.verified_user, color: Colors.green),
              focusedBorder: new OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              labelStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
              floatingLabelStyle:
              const TextStyle(color: Colors.green),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1))
          ),
    ));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            if(loading) return;
            setState(() => loading=true);
            await Future.delayed(Duration(seconds: 1));
            var response = await FirebaseCrud.updateEmployee(
                nombre: _nombre_comprador.text,
                apellido: _apellido_comprador.text,
                correo: _correo_comprador.text,
                telefono: _telefono_comprador.text,
                rol: _rol_comprador.text,
                estado: opciones,
                docId: _docid.text);
            if (response.code != 200) {
              mensajeError("Error", "Error al actualizar la información");
              setState(() => loading=false);
            } else {
              mensajeExito("Exito", "Información actualizada correctamente");
              setState(() => loading=false);
            }
          }
        },
        child: loading?
        Row(
          children: [
            CircularProgressIndicator(color: Colors.white),
            const SizedBox(width: 24),
            Text('Por favor espere ...'),
          ],
        )
            :Text('Actualizar'),
        style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(
                horizontal: 50, vertical: 20),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            )),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Actualizar usuario'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Container(
            child: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 25.0),
                  nombreField,
                  const SizedBox(height: 25.0),
                  apellidoField,
                  const SizedBox(height: 35.0),
                  correoField,
                  const SizedBox(height: 35.0),
                  rolField,
                  const SizedBox(height: 35.0),
                  telefonoField,
                  const SizedBox(height: 35.0),
                  dropdown,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],),),
      ),
    );
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
                        Navigator.of(context).pop();

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
                        Navigator.of(context).pop();

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