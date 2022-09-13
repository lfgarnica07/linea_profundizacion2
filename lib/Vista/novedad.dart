import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, home: novedad());
  }
}

class novedad extends StatefulWidget{
  @override
  novedadapp createState()=> novedadapp();

}
class novedadapp extends State<novedad> {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _precio= TextEditingController();
  TextEditingController _imagen= TextEditingController();


  final firebase=FirebaseFirestore.instance;
  final CollectionReference _produccion= FirebaseFirestore.instance.collection('productos');

  Future<void>_update([DocumentSnapshot documentSnapshot]) async{
    if(documentSnapshot !=null){
      _nombre.text=documentSnapshot['nombre'];
      _precio.text=documentSnapshot['precio'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder:(BuildContext ctx){
          return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom+20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombre,
                  decoration: const InputDecoration(labelText: 'Nombre del producto'),
                ),
                TextField(
                  controller: _precio,
                  decoration: const InputDecoration(labelText: 'Precio del producto'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Actualizar'),
                  onPressed: () async{
                    final String nombre =_nombre.text;
                    final String precio=_precio.text;
                    if(nombre!=null){
                      await _produccion
                          .doc(documentSnapshot.id)
                          .update({'nombre': nombre ,'precio':precio});
                      _nombre.text='';
                      _precio.text='';
                    }
                  },
                )
              ],
            ),
          );
        });
  }
  Future<void> _delete(String produccionId) async{
    await _produccion.doc(produccionId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Eliminado')));
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white70,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: StreamBuilder(
        stream: _produccion.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder:(context,index ){
                final DocumentSnapshot documentSnapshot=
                    streamSnapshot.data.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Nombre: '+documentSnapshot['nombre']),
                    subtitle: Text('Precio: '+documentSnapshot['precio']),
                    trailing: SizedBox(
                      width: 140,
                      child: Row(
                        children: [
                          Image.network(documentSnapshot['url']),
                          IconButton(
                            icon: const Icon(Icons.edit,color: Color.fromRGBO(205, 16, 77, 10)),
                            onPressed: ()=> _update(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete,color: Color.fromRGBO(205, 16, 77, 10)),
                              onPressed: ()=> _delete(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),

                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
