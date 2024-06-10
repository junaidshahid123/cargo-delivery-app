import 'dart:math';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/location_controller.dart';
import 'package:cargo_delivery_app/home/riderrequest/controller/ride_requests_controller.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../model/MDCreateRequest.dart';
import '../MySample.dart';
import '../bottom_navbar.dart';

class DriverRequestNotificationScreen extends StatefulWidget {
  final List<Drivers>? drivers;

  const DriverRequestNotificationScreen(
      {Key? key, this.drivers // Optional parameter with a default empty list
      })
      : super(key: key);

  @override
  State<DriverRequestNotificationScreen> createState() =>
      _DriverRequestNotificationScreenState();
}

class _DriverRequestNotificationScreenState
    extends State<DriverRequestNotificationScreen> {
  final controller = Get.put(LocationController(userRepo: UserRepo()));
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  final Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    // print('widget.drivers!.length====${widget.drivers!.length}');
    print('markers.length====${markers.length}');
    print('circles.length====${circles.length}');

    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: curvedBlueColor.withOpacity(0.76),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: CustomButton(
              buttonText: "Proceed".tr,
              onPress: () {
                Get.to(() => const BottomBarScreen());
              }),
        ),
      ),
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xff113946),
                  const Color(0xff113946).withOpacity(0.02),
                ],
              ),
            ),
            decoration: const BoxDecoration(),
            child: GoogleMap(
              zoomControlsEnabled: true,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
               polylines: _polylines,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              markers: Set<Marker>.of(markers),
              mapType: MapType.terrain,
              mapToolbarEnabled: true,
              initialCameraPosition: CameraPosition(
                target: controller.initialPos,
                zoom: 17,
              ),
              onMapCreated: controller.onCreated,
              onCameraMove: (CameraPosition position) =>
                  controller.onCameraMove(position),
              onCameraIdle: () async => controller.getMoveCamera(),
              circles: Set<Circle>.of(circles),
            ),
          ),
          Positioned(
            height: MediaQuery.sizeOf(context).height / 6,
            child: IconButton(
              onPressed: () {
                // You can use controller. () here to animate the camera to the initial position
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: MediaQuery.sizeOf(context).height / 10,
            height: MediaQuery.sizeOf(context).height - 180,
            child: _buildRiderRequests(),
          ),
        ],
      ),
    );
  }

  Widget _buildRiderRequests() {
    var rideController = Get.put(RideRequestsController(userRepo: UserRepo()));
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(
            rideController.requests.value?.offers?.length ?? 0,
            (index) {
              final request = rideController.requests.value?.offers![index];
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey(request),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xff5C5959),
                                  radius: 23,
                                  child: Image.asset(
                                    "assets/images/bus_icon.png",
                                    height: 23,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Car',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: curvedBlueColor,
                                      ),
                                    ),
                                    Text(
                                      request?.user?.name ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: curvedBlueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  request?.amount ?? '0.0',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textBrownColor,
                                  ),
                                ),
                                Text(
                                  "10 Mins",
                                  // "${request?.request.original.arrivalTime.minute}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: curvedBlueColor,
                                  ),
                                ),
                                Text(
                                  "${haversineDistance(
                                    double.tryParse(
                                            request?.request?.parcelLat ??
                                                '0.0') ??
                                        0.0,
                                    double.tryParse(
                                            request?.request?.parcelLong ??
                                                '0.0') ??
                                        0.0,
                                    double.tryParse(
                                            request?.user?.latitude ?? '0.0') ??
                                        0.0,
                                    double.tryParse(request?.user?.longitude ??
                                            '0.0') ??
                                        0.0,
                                  ).floor()} Km"
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: curvedBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomButton(
                                borderRadius: 100,
                                buttonColor: const Color(0xffF5F5F5),
                                buttonTextColor: const Color(0xffCF442B),
                                buttonText: "Decline",
                                onPress: () {
                                  rideController.requests.value?.offers
                                      ?.removeAt(index);

                                  setState(() {});
                                },
                                width: 145,
                                height: 37,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomButton(
                                buttonColor: const Color(0xff03AB3C),
                                buttonTextColor: Colors.white,
                                borderRadius: 100,
                                buttonText: "Accept",
                                onPress: () {
                                  print(
                                      'Driver lat : ${request?.user?.latitude}');
                                  print(
                                      'Driver lng : ${request?.user?.longitude}');
                                  Get.find<LocationController>()
                                      .setDriverLocation(LatLng(
                                    double.tryParse(
                                          request?.user?.latitude ?? '0.0',
                                        ) ??
                                        0.0,
                                    double.tryParse(
                                          request?.user?.longitude ?? '0.0',
                                        ) ??
                                        0.0,
                                  ));
                                  Get.find<RideRequestsController>()
                                      .acceptDriverRequest(
                                    requestId: '${request?.requestId}',
                                    offerId: '${request?.id}',
                                    amount: "${request?.amount}",
                                    card: '36436636343',
                                    driverId: request?.userId ?? '',
                                  );
                                },
                                width: 145,
                                height: 37,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  @override
  initState() {
    super.initState();

    if (widget.drivers != null && widget.drivers!.isNotEmpty) {
      addInitialPositionMarker();
      addDriverMarkers();
      final Polyline polyline = Polyline(
        polylineId: PolylineId('polyline_1'),
        points: [
          LatLng(31.4835, 74.3782),
          LatLng(
              controller.initialPos.latitude, controller.initialPos.longitude),
          LatLng(31.4834, 74.3969),
        ],
        color: Colors.black,
        width: 5,
      );

      circles.add(
        Circle(
          circleId: CircleId('1'),
          center: LatLng(31.4834, 74.3969),
          radius: 50,
          // Set your desired radius here
          fillColor: Colors.blue.withOpacity(0.3),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
      circles.add(
        Circle(
          circleId: CircleId('2'),
          center: LatLng(31.4835, 74.3782),
          radius: 50,
          // Set your desired radius here
          fillColor: Colors.blue.withOpacity(0.3),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
      circles.add(
        Circle(
          circleId: CircleId('3'),
          center: controller.initialPos,
          radius: 50,
          // Set your desired radius here
          fillColor: Colors.blue.withOpacity(0.3),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
    } else {
      print("No drivers data available");
    }
  }

  addInitialPositionMarker() async {
    markers.add(
      Marker(
        markerId: MarkerId('initial_pos'),
        position: controller.initialPos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('31.4834, 74.3969'),
        position: LatLng(31.4834, 74.3969),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    setState(() {});
    print('markers.length in addInitialPositionMarker=${markers.length}');
  }

  addDriverMarkers() {
    for (int i = 0; i < widget.drivers!.length; i++) {
      final driver = widget.drivers![i];
      if (driver.latitude != null && driver.longitude != null) {
        try {
          final lat = double.parse(driver.latitude!);
          final lng = double.parse(driver.longitude!);
          markers.add(
            Marker(
              markerId: MarkerId(driver.id.toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: driver.name),
            ),
          );
          print(
              'Added marker and circle for driver ${driver.name} at ($lat, $lng)');
        } catch (e) {
          print(
              'Error parsing latitude/longitude for driver ${driver.name}: $e');
        }
      } else {
        print('Latitude or Longitude is null for driver ${driver.name}');
      }
    }

    print('markers.length in addDriverMarkers : ${markers.length}');
    print('Total circles added: ${circles.length}');
  }
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusKm = 6371.0;

  final dLat = degreesToRadians(lat2 - lat1);
  final dLon = degreesToRadians(lon2 - lon1);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(degreesToRadians(lat1)) *
          cos(degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadiusKm * c;
}
