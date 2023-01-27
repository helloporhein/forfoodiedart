import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'home.dart';

class UserLocation extends StatefulWidget {
  double lat;
  double lon;
  UserLocation(this.lat,this.lon);

  //String customerId;
  //const LocationScreen({Key? key}) : super(key: key);
  //UserLocation(this.customerId);
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  bool loading = false;

  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition ;
  late Location location;
  late LocationData currentLocation;

  Set<Marker> _marker = {};
  late BitmapDescriptor locationIcon;

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
        appBar: AppBar(title: Text('Customer Location'),),
        body: GoogleMap(
          markers: _marker,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            LatLng pinPosition = LatLng(widget.lat,widget.lon);
            setState((){
              _marker.add(
            Marker(markerId: MarkerId('Icons'),
            position: pinPosition,
            icon: locationIcon
            )
            );
            });
          },
        ),
      ):Scaffold(body: CircularProgressIndicator(),);
  }

  void setInitialLocation() async {
    setMapIcon();

    initialCameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(widget.lat,widget.lon));

    setState(() {
      this.loading = true;
    });
  }

  void setMapIcon() async{
    locationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/googlemaps_pin.png');
  }
}
