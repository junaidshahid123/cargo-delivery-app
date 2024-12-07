import 'dart:convert';
import 'dart:io';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/request_ridecontroller.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import '../alltrips/controller/delivery_controller.dart';
import '../api/application_url.dart';
import '../widgets/auto_place_textfield.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DeliveryDetailsScreen extends StatefulWidget {
  final String? selectedVehicle;

  const DeliveryDetailsScreen({super.key, this.selectedVehicle});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  String? parcelAddress;
  String? receiverAddress;
  DeliveryController deliveryController = Get.put(DeliveryController());
  var fromCity = Rx<String?>(null);

  var toCity = Rx<String?>(null);

  List<XFile> pickedImage = [];

  final _parcelLoc = TextEditingController(),
      _receiverLoc = TextEditingController(),
      _receiverMob = TextEditingController();

  final _countryCode = Rx<String>('+996');

  final _parcelLat = Rx<String>('0.0');

  final _receiverLat = Rx<String>('0.0');

  final _parcelLan = Rx<String>('0.0');

  final _receiverLan = Rx<String>('0.0');

  final parcelCity = Rx<String>('0.0');
  final receiverCity = Rx<String>('0.0');

  Future<String?> _extractCity(Prediction prediction) async {
    String? formattedAddress = prediction.description;
    if (formattedAddress == null) return null;

    List<Location> locations = await locationFromAddress(formattedAddress);
    if (locations.isNotEmpty) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locations.first.latitude, locations.first.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
    }

    return null;
  }

  Future<String?> _extractCityFor(LatLng? location) async {
    if (location == null) return null;

    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality;
    }
    return null;
  }

  Future<void> _getAddressFromLatLngForParcelAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        parcelAddress =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAddressFromLatLngForReceiverAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        receiverAddress =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DeliveryController>(
            init: DeliveryController(),
            builder: (deliveryController) {
              return Container(
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                      textcyanColor,
                      textcyanColor.withOpacity(0.1)
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Text(
                            "Add Your Details for delivery".tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: curvedBlueColor),
                          ),
                        ],
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // SizedBox(height: 10.h),

                            SizedBox(height: 20.h),
                            InkWell(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    child: Image.file(
                                      File('${pickedImage[index].path}'),
                                      height: 50,
                                      width: 50,
                                    ),
                                  );
                                },
                                itemCount: pickedImage.length,
                              ),
                            ),
                            Text("Add Picture *".tr,
                                style: TextStyle(
                                    fontSize: 16.sp, color: backGroundColor)),
                            SizedBox(height: 10.h),
                            InkWell(
                              onTap: () async {
                                // Show a bottom sheet with options to choose from camera or gallery
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text("Camera".tr),
                                          onTap: () async {
                                            var image = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            if (image != null) {
                                              pickedImage.add(image);
                                            }
                                            if (mounted) setState(() {});
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.photo_library),
                                          title: Text("Gallery".tr),
                                          onTap: () async {
                                            var image = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              pickedImage.add(image);
                                            }
                                            if (mounted) setState(() {});
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Image.asset(
                                "assets/images/add_pic.png",
                                height: 51.h,
                              ),
                            ),
                            SizedBox(height: 30.h),
                            InkWell(
                              onTap: () async {
                                LatLng? pickedLocation =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlacePickerMapScreen(),
                                  ),
                                );
                                print('pickedLocation====${pickedLocation}');
                                String? city =
                                    await _extractCityFor(pickedLocation);
                                print('city In Parcel====${city}');
                                if (city != null) {
                                  parcelCity.value = city;
                                  _parcelLat.value =
                                      pickedLocation!.latitude.toString();
                                  _parcelLan.value =
                                      pickedLocation.longitude.toString();
                                  print(
                                      '_parcelLat.value====${_parcelLat.value}');
                                  print(
                                      '_parcelLan.value ====${_parcelLan.value}');
                                }
                                _getAddressFromLatLngForParcelAddress(
                                    pickedLocation!);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(12.0),
                                // margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                child: Text(
                                  parcelAddress != null
                                      ? parcelAddress!
                                      : 'Select your Parcel Location'.tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'RadioCanada',
                                      fontWeight: FontWeight.w400,
                                      color: textBrownColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            InkWell(
                              onTap: () async {
                                LatLng? pickedLocation =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlacePickerMapScreen(),
                                  ),
                                );
                                print('pickedLocation====${pickedLocation}');
                                String? city =
                                    await _extractCityFor(pickedLocation);
                                print('city In Receiver====${city}');
                                _receiverLat.value =
                                    pickedLocation!.latitude.toString();
                                _receiverLan.value =
                                    pickedLocation.longitude.toString();
                                print(
                                    '_receiverLat.value====${_receiverLat.value}');
                                print(
                                    '_receiverLan.value====${_receiverLan.value}');

                                _getAddressFromLatLngForReceiverAddress(
                                    pickedLocation);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(12.0),
                                // margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                child: Text(
                                  receiverAddress != null
                                      ? receiverAddress!
                                      : 'Select your Receiver Location'.tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'RadioCanada',
                                      fontWeight: FontWeight.w400,
                                      color: textBrownColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            ContactField(
                              onchange: (value) => _countryCode.value = value,
                              controller: _receiverMob,
                            ),
                            SizedBox(height: 40.h),
                            Obx(
                              () => Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (widget.selectedVehicle == null) {
                                        deliveryController.toggleDropDown();
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: (deliveryController
                                                    .showDropDown.value &&
                                                widget.selectedVehicle == null)
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                              )
                                            : BorderRadius.circular(13),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                widget.selectedVehicle != null
                                                    ? (widget.selectedVehicle ==
                                                            'Truck'
                                                        ? 'Truck Selected'.tr
                                                        : widget.selectedVehicle ==
                                                                'Car'
                                                            ? 'Car Selected'.tr
                                                            : widget
                                                                .selectedVehicle!)
                                                    : (deliveryController
                                                                .selectedVehicleName
                                                                .value !=
                                                            '-1'
                                                        ? deliveryController
                                                            .selectedVehicleName
                                                            .value
                                                        : 'Select Vehicle Category'
                                                            .tr),
                                                style: const TextStyle(
                                                  color: Color(0xffBCA37F),
                                                ),
                                              ),
                                            ),
                                            // Only show dropdown icon if widget.selectedVehicle is null
                                            if (widget.selectedVehicle == null)
                                              const Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Show dropdown list only if widget.selectedVehicle is null and dropdown is open
                                  if (widget.selectedVehicle == null &&
                                      deliveryController.showDropDown.value)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                        ),
                                      ),
                                      height: 100,
                                      child: deliveryController
                                                  .mdGetVehicleCategories ==
                                              null
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xffBCA37F),
                                              ),
                                            )
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    deliveryController
                                                        .tapOnVehicle(index);
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: deliveryController
                                                                  .mdGetVehicleCategories!
                                                                  .categories![
                                                                      index]
                                                                  .id ==
                                                              deliveryController
                                                                  .selectedVehicleId
                                                                  .value
                                                          ? const Color(
                                                              0xffBCA37F)
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13),
                                                      ),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      left: 20,
                                                      right: 20,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20),
                                                            child: Text(
                                                              deliveryController
                                                                  .mdGetVehicleCategories!
                                                                  .categories![
                                                                      index]
                                                                  .name!,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Image.network(
                                                            '${ApplicationUrl.IMAGE_ULR}/images/${deliveryController.mdGetVehicleCategories!.categories![index].image}',
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              final imageUrl =
                                                                  '${ApplicationUrl.IMAGE_ULR}/images/${deliveryController.mdGetVehicleCategories!.categories![index].image}';
                                                              print(
                                                                  "Complete Image URL: $imageUrl");
                                                              return buildErrorWidget(
                                                                  context,
                                                                  exception);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: deliveryController
                                                  .mdGetVehicleCategories!
                                                  .categories!
                                                  .length,
                                            ),
                                    ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                deliveryController.selectDate(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                width: MediaQuery.of(context).size.width,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        deliveryController
                                                .dateController.text.isNotEmpty
                                            ? deliveryController
                                                .dateController.text
                                            : 'Please Select Delivery Date'.tr,
                                        style:
                                            TextStyle(color: Color(0xffBCA37F)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            CustomButton(
                              buttonText: "Submit".tr,
                              onPress: () {
                                // Update `selectedVehicleId` based on the selected vehicle
                                if (widget.selectedVehicle == 'Car') {
                                  deliveryController.selectedVehicleId.value =
                                      '1';
                                  print(
                                      'deliveryController.selectedVehicleId.value=======${deliveryController.selectedVehicleId.value}');
                                }
                                if (widget.selectedVehicle == 'Truck') {
                                  deliveryController.selectedVehicleId.value =
                                      '2';
                                  print(
                                      'deliveryController.selectedVehicleId.value=======${deliveryController.selectedVehicleId.value}');
                                }

                                // Debug: Print all parameters before calling `createRideRequest`
                                print('parcel_city: ${parcelCity.value}');
                                print(
                                    'image: ${pickedImage.map((xFile) => File(xFile.path)).toList().toString()}');
                                print(
                                    'category_id: ${deliveryController.selectedVehicleId.value}');
                                print(
                                    'delivery_date: ${deliveryController.dateController.text}');
                                print('parcelLat: ${_parcelLat.value}');
                                print('parcelLong: ${_parcelLan.value}');
                                print('parcel_address: $parcelAddress');
                                print('receiveLat: ${_receiverLat.value}');
                                print('receiverLong: ${_receiverLan.value}');
                                print('receiverAddress: $receiverAddress');
                                print(
                                    'receiverMob: ${_countryCode.value + _receiverMob.text}');

                                // Call the method with the parameters
                                Get.find<RequestRideController>()
                                    .createRideRequest(
                                  parcel_city: parcelCity.value,
                                  image: pickedImage
                                      .map((xFile) => File(xFile.path))
                                      .toList(),
                                  category_id: deliveryController
                                      .selectedVehicleId.value,
                                  delivery_date:
                                      deliveryController.dateController.text,
                                  parcelLat: _parcelLat.value,
                                  parcelLong: _parcelLan.value,
                                  parcel_address: parcelAddress!,
                                  receiveLat: _receiverLat.value,
                                  receiverLong: _receiverLan.value,
                                  receiverAddress: receiverAddress!,
                                  receiverMob:
                                      _countryCode.value + _receiverMob.text,
                                );
                              },
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }));
  }

  Widget buildErrorWidget(BuildContext context, Object exception) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Text(
        'Image Not Available'.tr,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 7,
        ),
        maxLines: 1,
      ),
    ); // Return any Widget you want to display on error
  }
}

class PlacePickerMapScreen extends StatefulWidget {
  @override
  _PlacePickerMapScreenState createState() => _PlacePickerMapScreenState();
}

class _PlacePickerMapScreenState extends State<PlacePickerMapScreen> {
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;
  String? _pickedAddress;
  LatLng? _currentLocation;
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  String _apiKey = 'AIzaSyDdwlGhZKKQqYyw9f9iME40MzMgC9RL4ko';
  final _parcelLoc = TextEditingController(),
      _receiverLoc = TextEditingController(),
      _receiverMob = TextEditingController();
  final _parcelLat = Rx<String>('0.0');

  final _receiverLat = Rx<String>('0.0');

  final _parcelLan = Rx<String>('0.0');

  final _receiverLan = Rx<String>('0.0');

  final parcelCity = Rx<String>('0.0');
  final receiverCity = Rx<String>('0.0');

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<String?> _extractCity(Prediction prediction) async {
    String? formattedAddress = prediction.description;
    if (formattedAddress == null) return null;

    List<Location> locations = await locationFromAddress(formattedAddress);
    if (locations.isNotEmpty) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locations.first.latitude, locations.first.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
    }

    return null;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _pickedLocation = _currentLocation;
      _mapController
          ?.moveCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 14));
    });
    await _getAddressFromLatLng(_currentLocation!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Picker Map'.tr),
        actions: [
          if (_pickedLocation != null)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_currentLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 14,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onTap: (position) async {
                setState(() {
                  _pickedLocation = position;
                });
                await _getAddressFromLatLng(position);
              },
              markers: _pickedLocation == null
                  ? {}
                  : {
                      Marker(
                        markerId: MarkerId('picked-location'),
                        position: _pickedLocation!,
                      ),
                    },
              circles: _pickedLocation == null
                  ? {}
                  : {
                      Circle(
                        circleId: CircleId('picked-location-circle'),
                        center: _pickedLocation!,
                        radius: 500,
                        // radius in meters
                        fillColor: Colors.blue.withOpacity(0.2),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                      ),
                    },
            ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: AutoCompleteField(
              hintText: 'Search Location Here'.tr,
              controller: _parcelLoc,
              getPlaceDetailWithLatLng: (p0) {
                _parcelLat.value = p0.lat ?? '0.0';
                _parcelLan.value = p0.lng ?? '0.0';
              },
              itemClick: (p0) async {
                _parcelLoc.text = p0.description ?? '';
                List<Location> locations =
                    await locationFromAddress(p0.description!);
                if (locations.isNotEmpty) {
                  LatLng newPickedLocation = LatLng(
                      locations.first.latitude, locations.first.longitude);
                  String? city =
                      await _extractCityFromLatLng(newPickedLocation);
                  setState(() {
                    _pickedLocation = newPickedLocation;
                    _mapController?.moveCamera(
                        CameraUpdate.newLatLngZoom(_pickedLocation!, 14));
                  });
                  await _getAddressFromLatLng(newPickedLocation);
                  print('parcelLoc city: $city');
                  parcelCity.value = city!;
                }
              },
            ),
          ),
          if (_pickedAddress != null)
            Positioned(
              bottom: 100,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.all(10),
                child: Text(
                  _pickedAddress!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<String?> _extractCityFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _pickedAddress =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }
}
