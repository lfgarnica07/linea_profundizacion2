import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../carrito/carrito.dart';

class pantallaCarrito extends StatefulWidget {
  @override
  pantallaCarritoapp createState() => pantallaCarritoapp();
}
class pantallaCarritoapp extends State<pantallaCarrito> {
  Widget build(BuildContext context) {
    return Consumer<carrito>(builder:(context,carrito,child){
      return Scaffold(
        backgroundColor: Colors.white70,
        appBar:AppBar(
        title: Text('Pedidos'),
        elevation: 0,
          backgroundColor: Colors.pink,
        ),
        body: Container(
          child: carrito.items.length==0?
          Center(child: Text('Carrito vacio'),):Column(
            children: <Widget>[
              for(var item in carrito.items.values)
                Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('imagenes/'+item.imagen,width: 100,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(item.nombre),
                              Text(item.precio.toString()+'X'+item.unidad),
                              Row(
                                mainAxisSize: MainAxisSize.min ,
                                children: <Widget>[
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.remove,size: 13,color:Colors.white,),

                                      onPressed: (){
                                        setState(() {
                                          carrito.decrementarCantidadItem(item.id);
                                        });
                                      },
                                    ),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    child: Center(child: Text(item.cantidad.toString()),),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.add,size: 13,color:Colors.white,),
                                      onPressed: (){
                                        setState(() {
                                          carrito.incrementarCantidadItem(item.id);
                                        });
                                      },
                                    ),
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Color(0x99f0f0f0)
                        ),
                        child: Center(
                            child: Text((item.precio*item.cantidad).toString()),),),
                    ],
                  )
                ),
              Padding(padding:EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Subtotal: '),),
                  Text(carrito.subTotal.toStringAsFixed(2))
                ],
              ),
              ),
              Padding(padding:EdgeInsets.all(15),
                child:  Row(
                  children: <Widget>[
                    Expanded(child: Text('Impuesto: '),),
                    Text(carrito.impuesto.toStringAsFixed(2))
                  ],
                ),
              ),
              Padding(padding:EdgeInsets.all(15),
                child:  Row(
                  children: <Widget>[
                    Expanded(child: Text('Total: '),),
                    Text(carrito.total.toStringAsFixed(2))
                  ],
                )
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            String pedido='';
            carrito.items.forEach((key, value) {
              pedido='$pedido'+value.nombre+
                  'Cantidad: '+
                  value.cantidad.toString()+
                  ' Precio Unitario: '+
                  value.precio.toString()+
                  'Precio Total: '+
                  (value.cantidad*value.precio).toStringAsFixed(2)+
                  '\n*************************************\n';
            });
            pedido='$pedido' + 'Subtotal: '+ carrito.subTotal.toStringAsFixed(2)+'\n';
            pedido='$pedido' + 'Impuesto: '+ carrito.impuesto.toStringAsFixed(2)+'\n';
            pedido='$pedido' + 'Total: '+ carrito.total.toStringAsFixed(2)+'\n';
            log(pedido);
            //vinculo con whatsapp
            var celular='+573162502447';
            String mensaje= pedido;
            var url='whatsapp://Send?phone='+celular+'&text='+mensaje;
            "https://wa.me/$celular?text=$pedido";
            if(await canLaunch(url)){
              await launch(url);
            }else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Whatsapp no esta instalado')));
          }},
          backgroundColor: Colors.red,
          child: Icon(Icons.send,color: Colors.white,),
        ),
      );
    });
  }
}