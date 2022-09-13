import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:linea_profundizacion2/Vista/maps.dart';

class Geo extends StatefulWidget {
  GeoApp createState() => GeoApp();
}

class GeoApp extends State<Geo> {
  Position position;
  TextEditingController local =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(205, 16, 77, 10),
        title: Text('Ubicacion de las tiendas'),
        actions: [
          IconButton(
            onPressed: () async {
              local.text = (await _determinePosition()).toString();
              print(local.text);
            },
            icon: const Icon(Icons.add),
            // child: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => maps()));
                  },
                  child: Text('Posición'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10, right: 10),
                child: TextField(
                  controller: local,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Coordenadas ',
                    hintText: 'Coordenadas',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
    } else {
      await Geolocator.openLocationSettings();
    }
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print(await Geolocator.getCurrentPosition());

    return await Geolocator.getCurrentPosition();
  }
}