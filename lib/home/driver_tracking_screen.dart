import 'dart:async';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverTrackingScreen extends StatefulWidget {
  const DriverTrackingScreen({
    Key? key,
    this.shouldEmitLocation = false,
  }) : super(key: key);

  final bool shouldEmitLocation;

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  LatLng? driverLocation; // Store the driver's current location
  List<LatLng> pathPoints = [];
  final Set<Polyline> _polyline = {};

  // late PolylinePoints polylinePoints;
  StreamSubscription<Position>? streamSubscription;

  // Store the driver's path points
  Future<void> setPolyLines({
    required LatLng sourceLocation,
    required LatLng destinationLocation,
    LatLng? driverLocation,
  }) async {
    _polyline.clear();
    pathPoints.clear();
    // var result = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyDdwlGhZKKQqYyw9f9iME40MzMgC9RL4ko",
    //   // PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
    //   // PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    // );
    // if (result.points.isNotEmpty) {
    //   for (var element in result.points) {
    //     pathPoints.add(LatLng(element.latitude, element.longitude));
    //   }
    //   _polyline.add(Polyline(
    //     startCap: Cap.buttCap,
    //     endCap: Cap.buttCap,
    //     visible: true,
    //     width: 3,
    //     polylineId: const PolylineId('poly'),
    //     color: const Color.fromARGB(255, 40, 122, 198),
    //     points: pathPoints,
    //   ));
    //   setState(() {});
    // }
  }

  @override
  void initState() {
    super.initState();
    // polylinePoints = PolylinePoints();
    // Initialize the driver's location
    // Replace this with your mechanism to get the driver's location
    // driverLocation = Get.find<LocationController>().driverLocation;
    // // Initialize the driver's path points with the initial location
    // pathPoints.add(driverLocation!);
    // setPolyLines(
    //   sourceLocation: driverLocation!,
    //   destinationLocation: Get.find<LocationController>().initialPos,
    // );
    // if (widget.shouldEmitLocation) {
    //   streamSubscription =
    //       Geolocator.getPositionStream().listen((position) async {
    //     log('In Location Listener');
    //     final location = LocationModel(
    //       latitude: position.latitude,
    //       longitude: position.longitude,
    //     );
    //     MQTTClient.emitLocation(location, '19');
    //   });
  }

  @override
  void dispose() {
    // if (streamSubscription != null) streamSubscription!.cancel();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [textcyanColor, textcyanColor.withOpacity(0.01)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 78.h,
              color: textBrownColor,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/driver_way.png",
                    height: 18.h,
                    width: 30.w,
                  ),
                  SizedBox(width: 10.w),
                  const Text(
                      "Driver is on the way to collect your parcel.\nArrives in 15 minutes")
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                //     polylines: _polyline,
                myLocationEnabled: false,
                markers: Get
                    .find<LocationController>()
                    .markers,
                compassEnabled: false,
                onCameraMove: Get
                    .find<LocationController>()
                    .onCameraMove,
                initialCameraPosition: CameraPosition(
                    target: Get
                        .find<LocationController>()
                        .initialPos,
                    zoom: 18),
                onMapCreated: Get
                    .find<LocationController>()
                    .onCreated,
                onCameraIdle: () async {
                  Get.find<LocationController>().getMoveCamera();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
