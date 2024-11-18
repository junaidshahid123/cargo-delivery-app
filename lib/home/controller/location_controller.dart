import 'dart:developer';
import 'dart:ui' as ui;
import 'package:cargo_delivery_app/api/api_constants.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bottom_navbar.dart';

class LocationController extends GetxController implements GetxService {
  final UserRepo userRepo;

  LocationController({required this.userRepo});

  LatLng? _driverLocation;
  late LatLng _gpsActual;
  LatLng _initialPosition = const LatLng(-12.122711, -77.027475);
  var activeGps = true.obs;
  TextEditingController locationController = TextEditingController();
  late String city;
  late GoogleMapController _mapController;

  LatLng get gpsPosition => _gpsActual;

  LatLng get initialPos => _initialPosition;
  final Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  GoogleMapController get mapController => _mapController;

  Future<void> setDriverLocation(LatLng loc) async {
    _driverLocation = loc;
    _markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: loc,
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('assets/images/truck_icon.png'),
        ),
      ),
    );
    print('Marker Added');
    update();
  }

  LatLng get driverLocation => _driverLocation!;

  @override
  void onReady() async {
    super.onReady();
    getUserLocation();
  }

  void addDriverMarker(LatLng location, Uint8List icon) async {
    if (_markers.length == 1) {
      _markers.toList().removeAt(1);
    }
    _markers.add(Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      icon: BitmapDescriptor.fromBytes(icon),
    ));
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 14.4746),
    ));
  }

  void getMoveCamera() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      _initialPosition.latitude,
      _initialPosition.longitude,
    );
    city = placemark[0].locality!;
    locationController.text = placemark[0].name!;
  }

  void getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      activeGps.value = false;
    } else {
      activeGps.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _initialPosition = LatLng(position.latitude, position.longitude);
      log("the latitude is: ${position.latitude} and the longitude is: ${position.longitude} ");
      locationController.text = placemark[0].name!;
      log("initial position is : ${placemark[0].name}");
      _addMarker(_initialPosition, placemark[0].name!);
      update();
      _mapController.moveCamera(CameraUpdate.newLatLng(_initialPosition));
    }
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;

    // Add marker when map is created
    _addMarker(_initialPosition, locationController.text);
    update();
  }

  void _addMarker(LatLng location, String address) async {
    _markers.add(Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      infoWindow: InfoWindow(title: address, snippet: "Current Location"),
      icon: BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/images/profile_icon.png'),
      ),
    ));
  }

  Future<Uint8List> getBytesFromAsset(String path, [int width = 30]) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void onCameraMove(CameraPosition position) async {
    position = CameraPosition(target: initialPos, zoom: 18.0);
    _initialPosition = position.target;
  }

  void setLocation(
      {required String userId,
      required String address,
      required String lat,
      required String lang,
      required String city}) async
  {
    var response = await userRepo.confirmLocation(
      userId: userId,
      address: address,
      lat: lat,
      lang: lang,
      city: city,
    );
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      Get.to(() => const BottomBarScreen());
    } else {
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => CupertinoAlertDialog(
          content: const Text('Some thing went wrong'),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }
}
