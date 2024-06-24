import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../api/auth_controller.dart';
import '../model/MDTracking.dart';

class DriverTrackingScreen extends StatefulWidget {
  const DriverTrackingScreen({
    Key? key,
    required this.requestId,
    this.shouldEmitLocation = false,
  }) : super(key: key);

  final bool shouldEmitLocation;
  final String requestId;

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  MDTracking? mdTracking;
  final Set<Polyline> _polyline = {};

  Future<void> setPolyLines({
    required String sourceLat,
    required String sourceLng,
    required String destinationLat,
    required String destinationLng,
  }) async {
    _polyline.clear();

    final double sourceLatitude = double.parse(sourceLat);
    final double sourceLongitude = double.parse(sourceLng);
    final double destinationLatitude = double.parse(destinationLat);
    final double destinationLongitude = double.parse(destinationLng);

    final List<LatLng> points = [
      LatLng(sourceLatitude, sourceLongitude),
      LatLng(destinationLatitude, destinationLongitude),
    ];

    _polyline.add(Polyline(
      polylineId: const PolylineId('route'),
      points: points,
      color: Colors.blue,
      width: 5,
    ));
  }

  Future<void> trackShipment(String requestId) async {
    final url = Uri.parse('http://delivershipment.com/public/api/tracking');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}',
        },
        body: jsonEncode({
          'request_id': requestId,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        mdTracking = MDTracking.fromJson(responseData);

      setState(() {
        setPolyLines(
          sourceLat: mdTracking!.data!.parcelLat!,
          sourceLng: mdTracking!.data!.parcelLong!,
          destinationLat: mdTracking!.data!.receiverLat!,
          destinationLng: mdTracking!.data!.receiverLong!,
        );
      });
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    trackShipment(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 78,
              color: Colors.brown,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/driver_way.png",
                    height: 18,
                    width: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Driver is on the way to collect your parcel.\nArrives in 15 minutes",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                polylines: _polyline,
                markers: {
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: LatLng(
                      double.parse(mdTracking!.data!.receiverLat!),
                      double.parse(mdTracking!.data!.receiverLong!),
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                    infoWindow: const InfoWindow(title: 'Destination'),
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(mdTracking!.data!.parcelLat!),
                    double.parse(mdTracking!.data!.parcelLong!),
                  ),
                  zoom: 12,
                ),
                onMapCreated: (controller) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
