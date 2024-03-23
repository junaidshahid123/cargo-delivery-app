import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/bottom_navbar.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(24.4672, 39.6024),
              ),
            ),
          ),
          Positioned(
            top: 100.h,
            left: 20.w,
            right: 20.w,
            child: TextField(
              controller:
                  TextEditingController(text: 'Riyad Province - 11564 Riyad'),
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
                  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedErrorBorder:
                      OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          Positioned(
              top: 2.h,
              left: 2.w,
              child: buildBackButton(
                context,
                onTap: () => Get.back(),
                isTitle: false,
              )),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: CustomButton(
          buttonText: 'Confirm Location',
          onPress: () => Get.to(() => const BottomBarScreen())),
    );
  }
}
