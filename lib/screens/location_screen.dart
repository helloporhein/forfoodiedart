import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'home.dart';

class LocationScreen extends StatefulWidget {
  String customerId;
  //const LocationScreen({Key? key}) : super(key: key);
  LocationScreen(this.customerId);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  bool loading = false;

  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition ;
  late Location location;
  late LocationData currentLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitialLocation();
  }
  @override
  Widget build(BuildContext context) {
    return
      this.loading?
      Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        FirebaseFirestore.instance.collection('customers').doc(widget.customerId).update({
          'lat': currentLocation.latitude,
          'lon': currentLocation.longitude,
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return Home();
        }));
      },
      child: Text('Continue'),
      ),
      body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
      ), 
    ):Scaffold(body: CircularProgressIndicator(),);
  }
  
  void setInitialLocation() async {
    location = Location();
    currentLocation = await location.getLocation();
    initialCameraPosition = CameraPosition(
      zoom: 18,
        target: LatLng(currentLocation.latitude!,currentLocation.longitude!));
    setState(() {
      this.loading = true;
    });
  }
}
