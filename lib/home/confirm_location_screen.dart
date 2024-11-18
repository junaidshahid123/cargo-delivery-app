import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/location_controller.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    textcyanColor,
                    textcyanColor.withOpacity(0.5),
                  ],
                ),
              ),
              child: GoogleMap(
                compassEnabled: false,
                markers: controller.markers,
                onCameraMove: controller.onCameraMove,
                initialCameraPosition:
                    CameraPosition(target: controller.initialPos, zoom: 18),
                onMapCreated: controller.onCreated,
                onCameraIdle: () async {
                  controller.getMoveCamera();
                },

              ),
            ),
            Positioned(
              top: 100.h,
              left: 20.w,
              right: 20.w,
              child: TextField(
                readOnly: true,
                controller: controller.locationController,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.white12,
                    filled: true,
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    disabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    errorBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedErrorBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 10,
            left: 10,
            right: 10,
          ),
          child: CustomButton(
              buttonText: "confirm location".tr,
              onPress: () {
                final userId = '${Get.find<AuthController>().getLoginUserData()?.user?.id}';
                final address = controller.locationController.text;
                final city = controller.city;
                final latitude = '${controller.initialPos.latitude}';
                final longitude = '${controller.initialPos.longitude}';

                // Print all values
                print('User ID: $userId');
                print('Address: $address');
                print('City: $city');
                print('Latitude: $latitude');
                print('Longitude: $longitude');

                controller.setLocation(
                  userId: userId,
                  address: address,
                  city: city,
                  lat: latitude,
                  lang: longitude,
                );
              }
          ),
        ),
      ),
    );
  }
}
