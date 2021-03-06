import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
  MapSample({required this.index, required this.index1, required this.index2});
  final String index;
  final String index1;
  final String index2;
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.index), double.parse(widget.index1)),
              zoom: 16.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _markers.add(
                  Marker(
                    markerId: MarkerId(widget.index2),
                    position: LatLng(double.parse(widget.index), double.parse(widget.index1)),
                    infoWindow: InfoWindow(
                      title: widget.index2
                    )
                  )
                );
              });
              _controller.complete(controller);
            },
            trafficEnabled: true,
            markers: _markers,
          ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 50, left: 10),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Icon(Icons.arrow_back, color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}