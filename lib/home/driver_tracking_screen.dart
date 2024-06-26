import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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
  List<LatLng> pathPoints = [];
  late GoogleMapController _mapController;

  Future<void> setPolyLines({
    required String sourceLat,
    required String sourceLng,
    required String destinationLat,
    required String destinationLng,
  }) async {
    _polyline.clear();
    pathPoints.clear();

    final double sourceLatitude = double.parse(sourceLat);
    final double sourceLongitude = double.parse(sourceLng);
    final double destinationLatitude = double.parse(destinationLat);
    final double destinationLongitude = double.parse(destinationLng);

    final List<LatLng> points = [
      LatLng(sourceLatitude, sourceLongitude),
      LatLng(destinationLatitude, destinationLongitude),
    ];
    String apiKey = "AIzaSyDdwlGhZKKQqYyw9f9iME40MzMgC9RL4ko";

    try {
      // Request route from current location to source
      var currentToSourceResponse = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${sourceLatitude},${sourceLongitude}&destination=${destinationLatitude},${destinationLongitude}&key=$apiKey'));
      var currentToSourceData = jsonDecode(currentToSourceResponse.body);
      if (currentToSourceData['routes'].isEmpty) {
        throw Exception('No routes found from current location to source.');
      }
      var currentToSourceEncodedPoints =
          currentToSourceData['routes'][0]['overview_polyline']['points'];
      var currentToSourcePoints =
          decodeEncodedPolyline(currentToSourceEncodedPoints);

      // Request route from source to destination
      var sourceToDestinationResponse = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${sourceLatitude},${sourceLongitude}&destination=${destinationLatitude},${destinationLongitude}&key=$apiKey'));
      var sourceToDestinationData =
          jsonDecode(sourceToDestinationResponse.body);
      if (sourceToDestinationData['routes'].isEmpty) {
        throw Exception('No routes found from source to destination.');
      }
      var sourceToDestinationEncodedPoints =
          sourceToDestinationData['routes'][0]['overview_polyline']['points'];
      var sourceToDestinationPoints =
          decodeEncodedPolyline(sourceToDestinationEncodedPoints);

      // Add current location to pathPoints
      // pathPoints.add(currentLocation);

      // Add points from current to source
      // pathPoints.addAll(currentToSourcePoints);

      // Add points from source to destination
      pathPoints.addAll(sourceToDestinationPoints);

      _polyline.add(Polyline(
        polylineId: const PolylineId('poly'),
        color: const Color.fromARGB(255, 198, 40, 98),
        points: pathPoints,
        width: 8,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ));
      setState(() {});
      log('Polylines added successfully');
    } catch (e) {
      log('Error setting polylines: $e');
    }
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> trackShipment(String requestId) async {
    print(
        'Get.find<AuthController>().authRepo.getAuthToken()====${Get.find<AuthController>().authRepo.getAuthToken()}');
    final url = Uri.parse('http://delivershipment.com/public/api/tracking');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}',
        },
        body: jsonEncode({
          'request_id': requestId,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        mdTracking = MDTracking.fromJson(responseData);

        setPolyLines(
          sourceLat: mdTracking!.data!.parcelLat!,
          sourceLng: mdTracking!.data!.parcelLong!,
          destinationLat: mdTracking!.data!.receiverLat!,
          destinationLng: mdTracking!.data!.receiverLong!,
        );
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  void adjustCamera() {
    if (_polyline.isNotEmpty) {
      double minLat = _polyline
          .expand((polyline) => polyline.points)
          .map((point) => point.latitude)
          .reduce((value, element) => value < element ? value : element);
      double maxLat = _polyline
          .expand((polyline) => polyline.points)
          .map((point) => point.latitude)
          .reduce((value, element) => value > element ? value : element);
      double minLng = _polyline
          .expand((polyline) => polyline.points)
          .map((point) => point.longitude)
          .reduce((value, element) => value < element ? value : element);
      double maxLng = _polyline
          .expand((polyline) => polyline.points)
          .map((point) => point.longitude)
          .reduce((value, element) => value > element ? value : element);

      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );

      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
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
      body: mdTracking == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Colors.cyan, Colors.transparent],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
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
                      markers: _polyline.isNotEmpty
                          ? {
                              Marker(
                                markerId: const MarkerId('destination'),
                                position: LatLng(
                                  double.parse(mdTracking!.data!.receiverLat!),
                                  double.parse(mdTracking!.data!.receiverLong!),
                                ),
                                icon: BitmapDescriptor.defaultMarker,
                                infoWindow:
                                    const InfoWindow(title: 'Destination'),
                              ),
                            }
                          : {},
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(mdTracking!.data!.parcelLat!),
                          double.parse(mdTracking!.data!.parcelLong!),
                        ),
                        zoom: 12,
                      ),
                      onMapCreated: (controller) {
                        _mapController = controller;
                        adjustCamera();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
