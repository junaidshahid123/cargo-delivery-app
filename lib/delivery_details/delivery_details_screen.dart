import 'dart:convert';
import 'dart:io';
import 'dart:typed_data'; // Correct library to import
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/request_ridecontroller.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import '../api/application_url.dart';
import '../home/bottom_navbar.dart';
import '../profile/profile_page.dart';
import '../widgets/auto_place_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'delivery_details_logic.dart';
import 'delivery_details_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// ignore: must_be_immutable
class DeliveryDetailsScreen extends StatefulWidget {
  final String? selectedVehicle;

  const DeliveryDetailsScreen({super.key, this.selectedVehicle});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode mobileNuFocusNode = FocusNode();
  int _currentIndex = 0;

  String? parcelAddress;
  String? receiverAddress;

  // DeliveryController deliveryController = Get.put(DeliveryController());
  var fromCity = Rx<String?>(null);
  TextEditingController descriptionController = TextEditingController();
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

  // final List<Widget> _pages = [
  //   HomeScreen(),
  //   OrdersView(),
  //   ChatPage(),
  //   WalletView(),
  //   ProfilePage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocuses any focused field
      },
      child: Scaffold(
        body: GetBuilder<DeliveryController>(
            init: DeliveryController(),
            builder: (logic) {
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
                child: logic.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          fontSize: 16.sp,
                                          color: backGroundColor)),
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
                                                  var image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                  if (image != null) {
                                                    pickedImage.add(image);
                                                  }
                                                  if (mounted) setState(() {});
                                                  Navigator.pop(
                                                      context); // Close the bottom sheet
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title: Text("Gallery".tr),
                                                onTap: () async {
                                                  var image =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
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
                                  SizedBox(
                                    height: 60,
                                    // Fixed height for the TextField
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      // Padding for horizontal spacing
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                      ),
                                      child: TextField(
                                        controller: descriptionController,
                                        focusNode: descriptionFocusNode,
                                        decoration: InputDecoration(
                                          hintText: 'Add Description'.tr,
                                          hintStyle: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'RadioCanada',
                                            fontWeight: FontWeight.w400,
                                            color: textBrownColor,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical:
                                                  18.0), // Centers hint text vertically
                                        ),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'RadioCanada',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                        // Aligns input text to start
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // Vertically centers the input text
                                        onEditingComplete: () {
                                          descriptionFocusNode
                                              .unfocus(); // Close focus when editing is complete
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),

                                  SizedBox(
                                    height: 60,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
                                            // Row(
                                            //   children: [
                                            //     // From Dropdown
                                            //
                                            //     Flexible(
                                            //       flex: 1,
                                            //       child: Container(
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.white,
                                            //           border: Border.all(
                                            //             color: Colors.white,
                                            //             width: 1.0,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(13.0),
                                            //         ),
                                            //         child: DropdownButton<String>(
                                            //           isExpanded: true,
                                            //           hint: Padding(
                                            //             padding: EdgeInsets.only(
                                            //                 left: 12.0),
                                            //             // Add left padding to "From:"
                                            //             child: Text(
                                            //               'From:',
                                            //               style: TextStyle(
                                            //                 fontSize: 14.sp,
                                            //                 fontFamily: 'RadioCanada',
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //                 color: textBrownColor,
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           value: logic.fromValue,
                                            //           onChanged: (String? newValue) {
                                            //             setState(() {
                                            //               logic.fromValue = newValue!;
                                            //               logic.selectedCityFromId = logic
                                            //                   .mdCities
                                            //                   .firstWhere((city) =>
                                            //                       city.cityName ==
                                            //                       newValue)
                                            //                   .sno!; // Assuming MDCities has an `sno` property
                                            //               print(
                                            //                   "Selected From City ID: ${logic.selectedCityFromId}");
                                            //             });
                                            //           },
                                            //           underline: SizedBox.shrink(),
                                            //           icon: Icon(
                                            //               Icons.arrow_drop_down,
                                            //               color: textBrownColor),
                                            //           items: logic.mdCities.map<
                                            //                   DropdownMenuItem<
                                            //                       String>>(
                                            //               (MDCities city) {
                                            //             return DropdownMenuItem<
                                            //                 String>(
                                            //               value: city.cityName,
                                            //               child: Padding(
                                            //                 padding: EdgeInsets.only(
                                            //                     left: 8.0),
                                            //                 child: Text(
                                            //                   city.cityName!,
                                            //                   style: TextStyle(
                                            //                     fontSize: 14.sp,
                                            //                     fontFamily:
                                            //                         'RadioCanada',
                                            //                     fontWeight:
                                            //                         FontWeight.w400,
                                            //                     color: Colors.black,
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             );
                                            //           }).toList(),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     SizedBox(width: 20),
                                            //     // To Dropdown
                                            //     Flexible(
                                            //       flex: 1,
                                            //       child: Container(
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.white,
                                            //           border: Border.all(
                                            //             color: Colors.white,
                                            //             width: 1.0,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(13.0),
                                            //         ),
                                            //         child: DropdownButton<String>(
                                            //           isExpanded: true,
                                            //           hint: Padding(
                                            //             padding: EdgeInsets.only(
                                            //                 left: 12.0),
                                            //             // Add left padding to "To:"
                                            //             child: Text(
                                            //               'To:',
                                            //               style: TextStyle(
                                            //                 fontSize: 14.sp,
                                            //                 fontFamily: 'RadioCanada',
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //                 color: textBrownColor,
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           value: logic.toValue,
                                            //           onChanged: (String? newValue) {
                                            //             setState(() {
                                            //               logic.toValue = newValue!;
                                            //               logic.selectedCityToId = logic
                                            //                   .mdCities
                                            //                   .firstWhere((city) =>
                                            //                       city.cityName ==
                                            //                       newValue)
                                            //                   .sno!; // Assuming MDCities has an `sno` property
                                            //               print(
                                            //                   "Selected To City ID: ${logic.selectedCityToId}");
                                            //             });
                                            //           },
                                            //           underline: SizedBox.shrink(),
                                            //           icon: Icon(
                                            //               Icons.arrow_drop_down,
                                            //               color: textBrownColor),
                                            //           items: logic.mdCities.map<
                                            //                   DropdownMenuItem<
                                            //                       String>>(
                                            //               (MDCities city) {
                                            //             return DropdownMenuItem<
                                            //                 String>(
                                            //               value: city.cityName,
                                            //               child: Padding(
                                            //                 padding: EdgeInsets.only(
                                            //                     left: 8.0),
                                            //                 child: Text(
                                            //                   city.cityName!,
                                            //                   style: TextStyle(
                                            //                     fontSize: 14.sp,
                                            //                     fontFamily:
                                            //                         'RadioCanada',
                                            //                     fontWeight:
                                            //                         FontWeight.w400,
                                            //                     color: Colors.black,
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             );
                                            //           }).toList(),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            Row(
                                          children: [
                                            CustomPopup(
                                              mdCities: logic.mdCities,
                                              hint: "From:",
                                              onValueChanged: (value) {
                                                logic.fromValue = value;
                                                logic.selectedCityFromId = logic
                                                    .mdCities
                                                    .firstWhere((city) =>
                                                        city.cityName == value)
                                                    .sno!;
                                                print(
                                                    "Selected From City ID: ${logic.selectedCityFromId}");
                                              },
                                            ),
                                            SizedBox(width: 20),
                                            CustomPopup(
                                              mdCities: logic.mdCities,
                                              hint: "To:",
                                              onValueChanged: (value) {
                                                logic.toValue = value;
                                                logic.selectedCityToId = logic
                                                    .mdCities
                                                    .firstWhere((city) =>
                                                        city.cityName == value)
                                                    .sno!;
                                                print(
                                                    "Selected To City ID: ${logic.selectedCityToId}");
                                              },
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(height: 20.h),
                                  InkWell(
                                    onTap: () async {
                                      descriptionFocusNode.unfocus();
                                      mobileNuFocusNode.unfocus();
                                      LatLng? pickedLocation =
                                          await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PlacePickerMapScreen(),
                                        ),
                                      );
                                      print(
                                          'pickedLocation====${pickedLocation}');
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
                                      if (pickedLocation != null) {
                                        _getAddressFromLatLngForParcelAddress(
                                            pickedLocation);
                                      }
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
                                        borderRadius:
                                            BorderRadius.circular(13.0),
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
                                  // SizedBox(height: 20.h),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     LatLng? pickedLocation =
                                  //         await Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             PlacePickerMapScreen(),
                                  //       ),
                                  //     );
                                  //     print('pickedLocation====${pickedLocation}');
                                  //     String? city =
                                  //         await _extractCityFor(pickedLocation);
                                  //     print('city In Receiver====${city}');
                                  //     _receiverLat.value =
                                  //         pickedLocation!.latitude.toString();
                                  //     _receiverLan.value =
                                  //         pickedLocation.longitude.toString();
                                  //     print(
                                  //         '_receiverLat.value====${_receiverLat.value}');
                                  //     print(
                                  //         '_receiverLan.value====${_receiverLan.value}');
                                  //
                                  //     _getAddressFromLatLngForReceiverAddress(
                                  //         pickedLocation);
                                  //   },
                                  //   child: Container(
                                  //     width: MediaQuery.of(context).size.width,
                                  //     padding: EdgeInsets.all(12.0),
                                  //     // margin: EdgeInsets.all(8.0),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       border: Border.all(
                                  //         color: Colors.white,
                                  //         width: 1.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(13.0),
                                  //     ),
                                  //     child: Text(
                                  //       receiverAddress != null
                                  //           ? receiverAddress!
                                  //           : 'Select your Receiver Location'.tr,
                                  //       style: TextStyle(
                                  //           fontSize: 16.sp,
                                  //           fontFamily: 'RadioCanada',
                                  //           fontWeight: FontWeight.w400,
                                  //           color: textBrownColor),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 20.h),
                                  ContactField(
                                    onchange: (value) =>
                                        _countryCode.value = value,
                                    controller: _receiverMob,
                                    hintText:
                                        "Enter your receiver mobile number".tr,
                                    hintTextFontSize: 14.5,
                                    hintTextColor: textBrownColor,
                                    focusNode:
                                        mobileNuFocusNode, // Provide a custom FocusNode if needed
                                  ),

                                  SizedBox(height: 20.h),
                                  Obx(
                                    () => Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            descriptionFocusNode.unfocus();
                                            mobileNuFocusNode.unfocus();
                                            if (widget.selectedVehicle ==
                                                null) {
                                              logic.toggleDropDown();
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 45.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: (logic
                                                          .showDropDown.value &&
                                                      widget.selectedVehicle ==
                                                          null)
                                                  ? const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(13),
                                                      topRight:
                                                          Radius.circular(13),
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
                                                      widget.selectedVehicle !=
                                                              null
                                                          ? (widget
                                                                      .selectedVehicle ==
                                                                  'Truck'
                                                              ? 'Truck Selected'
                                                                  .tr
                                                              : widget.selectedVehicle ==
                                                                      'Car'
                                                                  ? 'Car Selected'
                                                                      .tr
                                                                  : widget
                                                                      .selectedVehicle!)
                                                          : (logic.selectedVehicleName
                                                                      .value !=
                                                                  '-1'
                                                              ? logic
                                                                  .selectedVehicleName
                                                                  .value
                                                              : 'Select Vehicle Category'
                                                                  .tr),
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xffBCA37F),
                                                      ),
                                                    ),
                                                  ),
                                                  // Only show dropdown icon if widget.selectedVehicle is null
                                                  if (widget.selectedVehicle ==
                                                      null)
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
                                            logic.showDropDown.value)
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                              ),
                                            ),
                                            height: 100,
                                            child:
                                                logic.mdGetVehicleCategories ==
                                                        null
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color(0xffBCA37F),
                                                        ),
                                                      )
                                                    : ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              logic
                                                                  .tapOnVehicle(
                                                                      index);
                                                            },
                                                            child: Container(
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: logic
                                                                            .mdGetVehicleCategories!
                                                                            .categories![
                                                                                index]
                                                                            .id ==
                                                                        logic
                                                                            .selectedVehicleId
                                                                            .value
                                                                    ? const Color(
                                                                        0xffBCA37F)
                                                                    : Colors
                                                                        .transparent,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13),
                                                                ),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 5,
                                                                bottom: 5,
                                                                left: 20,
                                                                right: 20,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        logic
                                                                            .mdGetVehicleCategories!
                                                                            .categories![index]
                                                                            .name!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10),
                                                                    child: Image
                                                                        .network(
                                                                      '${ApplicationUrl.IMAGE_ULR}/images/${logic.mdGetVehicleCategories!.categories![index].image}',
                                                                      errorBuilder: (BuildContext context,
                                                                          Object
                                                                              exception,
                                                                          StackTrace?
                                                                              stackTrace) {
                                                                        final imageUrl =
                                                                            '${ApplicationUrl.IMAGE_ULR}/images/${logic.mdGetVehicleCategories!.categories![index].image}';
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
                                                        itemCount: logic
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
                                      // Unfocus both focus nodes
                                      descriptionFocusNode.unfocus();
                                      mobileNuFocusNode.unfocus();
                                      logic.selectDate(context);
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
                                              logic.dateController.text
                                                      .isNotEmpty
                                                  ? logic.dateController.text
                                                  : 'Please Select Delivery Date'
                                                      .tr,
                                              style: TextStyle(
                                                  color: Color(0xffBCA37F)),
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
                                        logic.selectedVehicleId.value = '1';
                                        print(
                                            'logic.selectedVehicleId.value=======${logic.selectedVehicleId.value}');
                                      }
                                      if (widget.selectedVehicle == 'Truck') {
                                        logic.selectedVehicleId.value = '2';
                                        print(
                                            'deliveryController.selectedVehicleId.value=======${logic.selectedVehicleId.value}');
                                      }
                                      print(
                                          'deliveryController.selectedVehicleId.value========${logic.selectedVehicleId.value}');
                                      print(
                                          'descriptionController.text========${descriptionController.text}');
                                      // Debug: Print all parameters before calling `createRideRequest`
                                      print('parcel_city: ${parcelCity.value}');
                                      print(
                                          'image: ${pickedImage.map((xFile) => File(xFile.path)).toList().toString()}');
                                      print(
                                          'category_id: ${logic.selectedVehicleId.value}');
                                      print(
                                          'delivery_date: ${logic.dateController.text}');
                                      print('parcelLat: ${_parcelLat.value}');
                                      print('parcelLong: ${_parcelLan.value}');
                                      print('parcel_address: $parcelAddress');
                                      // print('receiveLat: ${_receiverLat.value}');
                                      // print('receiverLong: ${_receiverLan.value}');
                                      // print('receiverAddress: $receiverAddress');
                                      print(
                                          'receiverMob: ${_countryCode.value + _receiverMob.text}');
                                      if (pickedImage.isEmpty) {
                                        Get.snackbar(
                                          'Alert'.tr,
                                          'Please select at least one image'.tr,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else if (descriptionController
                                          .text.isEmpty) {
                                        Get.snackbar('Alert'.tr,
                                            'Please Enter Description'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (logic.selectedCityFromId ==
                                          '-1') {
                                        Get.snackbar('Alert'.tr,
                                            'Please Select City (From:)'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (logic.selectedCityToId ==
                                          '-1') {
                                        Get.snackbar('Alert'.tr,
                                            'Please Select City (To:)'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (parcelAddress == null) {
                                        Get.snackbar('Alert'.tr,
                                            'Please Enter Parcel Address'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (_receiverMob.text.isEmpty) {
                                        Get.snackbar(
                                            'Alert'.tr,
                                            'Please Enter Receiver Mobile Number'
                                                .tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (logic
                                              .selectedVehicleId.value ==
                                          '0') {
                                        Get.snackbar('Alert'.tr,
                                            'Please Select Vehicle'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (logic
                                              .selectedVehicleId.value ==
                                          '0') {
                                        Get.snackbar('Alert'.tr,
                                            'Please Select Vehicle'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else if (logic
                                          .dateController.text.isEmpty) {
                                        Get.snackbar('Alert'.tr,
                                            'Please Select Delivery Date'.tr,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      } else {
                                        //  Call the method with the parameters
                                        Get.find<RequestRideController>()
                                            .createRideRequest(
                                          parcel_city: parcelCity.value,
                                          image: pickedImage
                                              .map((xFile) => File(xFile.path))
                                              .toList(),
                                          category_id:
                                              logic.selectedVehicleId.value,
                                          delivery_date:
                                              logic.dateController.text,
                                          parcelLat: _parcelLat.value,
                                          parcelLong: _parcelLan.value,
                                          parcel_address: parcelAddress!,
                                          from: logic.selectedCityFromId,
                                          to: logic.selectedCityToId,
                                          // receiveLat: _receiverLat.value,
                                          // receiverLong: _receiverLan.value,
                                          // receiverAddress: receiverAddress!,
                                          receiverMob: _countryCode.value +
                                              _receiverMob.text,
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
              );
            }),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: textcyanColor,
          // Color for selected item (icon + label)
          unselectedItemColor: Colors.grey,
          // Color for unselected items (icon + label)
          selectedLabelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          // Label style for selected item
          unselectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          // Label style for unselected item
          currentIndex: _currentIndex,
          onTap: (int index) {
            // Pass the selected index to the BottomBarScreen
            Get.offAll(BottomBarScreen(
                initialIndex: index)); // Sending the selected index here
            setState(() {
              _currentIndex = index;
            });
          },
          showSelectedLabels: true,
          // Always show labels for selected item
          showUnselectedLabels: true,
          // Always show labels for unselected items
          items: [
            BottomNavigationBarItem(
              label: "Home".tr, // Label for Home tab
              icon: Image.asset(
                "assets/images/homeIcon.png",
                height: 30.h,
                width: 30.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "Orders".tr, // Label for Orders tab
              icon: Image.asset(
                "assets/images/oderImage.jpg",
                height: 30.h,
                width: 30.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "Chat".tr, // Label for Chat tab
              icon: Image.asset(
                "assets/images/chat_icon.png",
                height: 30.h,
                width: 30.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "Wallet".tr, // Label for Profile tab
              icon: Image.asset(
                "assets/images/walletIcon.jpg",
                height: 30.h,
                width: 30.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "More".tr, // Label for More tab
              icon: Image.asset(
                "assets/images/moreImage.jpg",
                height: 30.h,
                width: 30.w,
              ),
            ),
          ],
        ),
      ),
    );
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

class CustomPopup extends StatefulWidget {
  final List<MDCities> mdCities; // List of cities passed from logic.mdCities
  final String hint; // Hint for the dropdown
  final ValueChanged<String?> onValueChanged; // Callback for value change

  CustomPopup({
    required this.mdCities,
    required this.onValueChanged,
    required this.hint,
  });

  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  RxString selectedValue = ''.obs;
  String searchQuery = '';
  bool showNoMatchesMessage = false;

  // Filtered list based on the search query
  List<MDCities> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = widget.mdCities; // Initially show all cities
  }

  @override
  void didUpdateWidget(CustomPopup oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.mdCities != widget.mdCities) {
      // If cities list has changed, reset the filteredCities to the new list
      setState(() {
        filteredCities = widget.mdCities;
      });
    }
  }

  filterCities(String query) {
    setState(() {
      searchQuery = query;

      // Filter the cities based on the search query
      filteredCities = widget.mdCities
          .where((city) =>
              city.cityName != null &&
              city.cityName!.toLowerCase().startsWith(query.toLowerCase()))
          .toList();

      // If no matches are found, show the "No Matched Items" message
      showNoMatchesMessage = filteredCities.isEmpty && query.isNotEmpty;
    });

    // If no matches, reset after 2 seconds
    if (showNoMatchesMessage) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            // Clear the search query and reset the filtered cities
            searchQuery = '';
            filteredCities = widget.mdCities; // Reset to all cities
            showNoMatchesMessage = false; // Hide the "No Matched Items" message
          });
        }
      });
    }
  }

  void _showCityDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height -
                200, // Set the full height minus 200
            width: MediaQuery.of(context).size.width -
                20, // Set the width minus 20
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (query) {
                          filterCities(query);
                          setState(() {}); // Trigger the dialog state update
                        },
                      );
                    },
                  ),
                ),
                if (showNoMatchesMessage)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        "No Matched Items",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                Expanded(
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return ListView(
                        children: filteredCities.map((city) {
                          return ListTile(
                            title: Text(city.cityName!),
                            onTap: () {
                              setState(() {
                                selectedValue.value = city.cityName!;
                              });
                              widget.onValueChanged(city.cityName);
                              Navigator.of(context)
                                  .pop(); // Close the dialog after selecting
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: _showCityDialog, // Show the popup when clicked
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Row(
              children: [
                // Wrap the Text widget in an Expanded or Flexible widget
                Expanded(
                  child: Container(
                    // color: Colors.black,
                    child: Obx(
                      () {
                        String displayValue = selectedValue.value.isNotEmpty
                            ? selectedValue.value
                            : widget.hint;
                        return Text(
                          displayValue,
                          overflow: TextOverflow.ellipsis,
                          // Ensure long text doesn't overflow
                          maxLines: 2,
                          // Ensure only one line of text is shown
                          style: TextStyle(
                            fontSize: displayValue.length > 6 ? 10.0 : 14.0,
                            // Reduce font size if text length is more than 6
                            fontFamily: 'RadioCanada',
                            fontWeight: FontWeight.w400,
                            color: Colors.brown,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.brown),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlacePickerMapScreen extends StatefulWidget {
  @override
  _PlacePickerMapScreenState createState() => _PlacePickerMapScreenState();
}

class _PlacePickerMapScreenState extends State<PlacePickerMapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Request location permissions
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

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _pickedLocation = _currentLocation;
    });
  }

  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void _goToCurrentLocation() {
    if (_currentLocation != null) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentLocation!, zoom: 14),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a Location'),
      ),
      body: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
              color: textcyanColor,
            ))
          : Stack(
              children: [
                // Google Map
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 14,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  onCameraMove: (position) {
                    setState(() {
                      _pickedLocation = position.target;
                    });
                  },
                  // Disable default controls
                  myLocationButtonEnabled: false,
                  // Disable the default location button
                  myLocationEnabled: false,
                  // Disable the default location layer
                  zoomControlsEnabled: false,
                  // Disable zoom controls
                  compassEnabled: false, // Disable the compass
                ),

                // Custom Pin in the center of the map
                Center(
                  child: Image.asset(
                    'assets/images/locationIcon.png',
                    height: 75,
                    width: 75,
                    color: Colors.red,
                  ),
                ),

                // Zoom-in Button
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: Column(
                    children: [
                      // Zoom In
                      FloatingActionButton(
                        heroTag: "zoomIn",
                        onPressed: _zoomIn,
                        mini: true,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      // Zoom Out
                      FloatingActionButton(
                        heroTag: "zoomOut",
                        onPressed: _zoomOut,
                        mini: true,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.remove, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Back to Current Location Button
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: FloatingActionButton(
                    heroTag: "currentLocation",
                    onPressed: _goToCurrentLocation,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.my_location, color: Colors.black),
                  ),
                ),

                // Confirmation button at the bottom
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffBCA37F),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_pickedLocation != null) {
                        Navigator.of(context).pop(_pickedLocation);
                      }
                    },
                    child: Text(
                      'Confirm Location',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class PlacePickerMapScreenA extends StatefulWidget {
  @override
  _PlacePickerMapScreenAState createState() => _PlacePickerMapScreenAState();
}

class _PlacePickerMapScreenAState extends State<PlacePickerMapScreenA> {
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
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadCustomMarker(size: 100);
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

  Future<void> _loadCustomMarker({required double size}) async {
    // Load the image from assets
    final ByteData data =
        await rootBundle.load('assets/images/junaidImage-removebg-preview.ico');
    final Uint8List bytes = data.buffer.asUint8List();

    // Decode the image
    img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

    // Resize the image to the desired size
    img.Image resizedImage =
        img.copyResize(image, width: size.toInt(), height: size.toInt());

    // Convert the resized image to bytes
    Uint8List resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

    // Create a BitmapDescriptor from the resized byte array
    BitmapDescriptor customIcon = BitmapDescriptor.fromBytes(resizedBytes);

    setState(() {
      _customIcon = customIcon; // Set the custom icon
    });
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
                        icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                        // Custom marker
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
