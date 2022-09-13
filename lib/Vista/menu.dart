import 'package:flutter/material.dart';
import 'package:linea_profundizacion2/DTO/user.dart';
import 'package:linea_profundizacion2/Vista/maps.dart';
import 'package:linea_profundizacion2/Vista/pantallaCarrito.dart';
import 'package:linea_profundizacion2/carrito/carrito.dart';
import 'package:provider/provider.dart';
import 'Geo.dart';
import 'novedad.dart';
import 'package:linea_profundizacion2/models/carta.dart';

class menu extends StatefulWidget {
  final user userOb1;
  menu(this.userOb1);
  @override
  menuapp createState() => menuapp(user());
}
class menuapp extends State<menu>{
  final GlobalKey<ScaffoldState>_globalKey=new GlobalKey<ScaffoldState>();
  @override
  final user userOb1;
  menuapp(this.userOb1);

  Widget build(BuildContext context) {
    return Consumer<carrito>(builder:(context,carrito,child){
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _globalKey,
          backgroundColor: Colors.pink,
          appBar: AppBar(
            title: Text("Carta"),
            backgroundColor: Colors.pink,
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: Text('Platos'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: Text('Bebidas'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: Text('Postres'),
                  ),
                )
              ],
            ),
            actions: [
              Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed:(){
                      carrito.numeroItems!=0?
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>pantallaCarrito()
                          ))
                          :
                              _globalKey.currentState?.showSnackBar(SnackBar(
                              content: Text('Agregar un producto',textAlign: TextAlign.center,)
                      ));
                    },
                  ),
                  new Positioned(
                    top: 6,
                      right: 6,
                      child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(4)
                    ),
                        constraints: BoxConstraints(
                          maxWidth: 14,
                          maxHeight: 14
                        ),
                        child: Text(
                          carrito.numeroItems.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          color: Colors.pink,
                            fontSize: 10
                        ),),
                  ))
                ],
              )
            ],
          ),
          drawer: MenuLateral(userOb1),
          body: TabBarView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: platos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/1.1),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 2
                  ),
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                                color: Color(0x000005cc),
                                blurRadius: 30,
                                offset: Offset(10,10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset('imagenes/'+platos[index].imagen),
                          Text(platos[index].nombre,style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(platos[index].precio.toString(),style: TextStyle(fontSize: 16),),
                          ),
                          RaisedButton.icon(
                            onPressed: (){
                              setState(() {
                                carrito.agregarItem(
                                    platos[index].id.toString(),
                                    platos[index].nombre,
                                    platos[index].precio,
                                    '1',
                                    platos[index].imagen,
                                    1
                                );
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20)
                              )
                            ),
                            color: Colors.pink,
                            textColor: Colors.white,
                            icon: Icon(Icons.add_shopping_cart),
                            label: Text('Agregar'),
                            elevation: 0,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: bebidas.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/1.15),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 2
                  ),
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                                color: Color(0x000005cc),
                                blurRadius: 30,
                                offset: Offset(10,10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset('imagenes/'+bebidas[index].imagen),
                          Text(bebidas[index].nombre,style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(bebidas[index].precio.toString(),style: TextStyle(fontSize: 16),),
                          ),
                          RaisedButton.icon(
                            onPressed: (){
                              setState(() {
                                carrito.agregarItem(
                                    bebidas[index].id.toString(),
                                    bebidas[index].nombre,
                                    bebidas[index].precio,
                                    '1',
                                    bebidas[index].imagen,
                                    1
                                );
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)
                                )
                            ),
                            color: Colors.pink,
                            textColor: Colors.white,
                            icon: Icon(Icons.add_shopping_cart),
                            label: Text('Agregar'),
                            elevation: 0,
                          )
                        ],
                      ),
                    );
                  },
                ),),
              Container(padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: postres.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/1.15),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 2
                  ),
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                                color: Color(0x000005cc),
                                blurRadius: 30,
                                offset: Offset(10,10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset('imagenes/'+postres[index].imagen),
                          Text(postres[index].nombre,style: TextStyle(fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(postres[index].precio.toString(),style: TextStyle(fontSize: 16),),
                          ),
                          RaisedButton.icon(
                            onPressed: (){
                              setState(() {
                                carrito.agregarItem(
                                    postres[index].id.toString(),
                                    postres[index].nombre,
                                    postres[index].precio,
                                    '1',
                                    postres[index].imagen,
                                    1
                                );
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)
                                )
                            ),
                            color: Colors.pink,
                            textColor: Colors.white,
                            icon: Icon(Icons.add_shopping_cart),
                            label: Text('Agregar'),
                            elevation: 0,
                          )
                        ],
                      ),
                    );
                  },
                ),)
            ],
          ),
        ),
      );
    });
  }
}
class MenuLateral extends StatelessWidget{
  final user userOb1;
  MenuLateral(this.userOb1);
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(userOb1.nombre),
            accountEmail: Text(userOb1.correo),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://softimiza.co/images/Noticias_2021/gestion-de-pedidos1.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Ink(
            color: Color.fromRGBO(205, 16, 77, 10),
            child: new ListTile(
              title: Text("Tiendas", style: TextStyle(color: Colors.white),),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => maps()));
              },
            ),
          ),
          Ink(
          color: Color.fromRGBO(206, 0, 59, 10),
          child:new ListTile(
            title: Text("Registro de produccion",style: TextStyle(color: Colors.white),),
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => novedad()));
            },
          ),
          ),
          new ListTile(
            title: Text(""),
          ),
          new ListTile(
            title: Text(""),
          )

        ],
      ) ,
    );
  }
}