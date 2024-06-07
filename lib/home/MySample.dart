import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  late LatLng _origin;
  late LatLng _destination;
  late Set<Polyline> _polylines;

  @override
  void initState() {
    super.initState();
    _origin = LatLng(31.561920, 74.348080); // San Francisco
    _destination = LatLng(31.4835, 74.3782); // Oakland
    _polylines = {};
    _getDirections();
  }

  void _getDirections() async {
    String apiKey = 'AIzaSyDdwlGhZKKQqYyw9f9iME40MzMgC9RL4ko';
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<LatLng> points =
          _decodePoly(data['routes'][0]['overview_polyline']['points']);
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: points,
          width: 5,
          color: Colors.blue,
        ));
      });
    } else {
      print('Failed to fetch directions');
    }
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;

      poly.add(LatLng(latDouble, lngDouble));
    }

    return poly;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Flutter'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target:LatLng(31.561920, 74.348080),
          zoom: 50.0,
        ),
        polylines: _polylines,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _origin = LatLng(31.561920, 74.348080); // San Francisco
            _destination = LatLng(31.4835, 74.3782); // Oakland
            _getDirections();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
