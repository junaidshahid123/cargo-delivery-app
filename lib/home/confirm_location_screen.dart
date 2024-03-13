import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 50.h,
            ),
            buildBackButton(
              context,
              onTap: () => Get.back(),
            ),
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(33.257, 73.725),
              ),
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Riyad Province -11564\n Riyyad',
            )
          ],
        ),
      ),
    );
  }
}
