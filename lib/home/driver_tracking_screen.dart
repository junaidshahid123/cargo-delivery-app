import 'package:cargo_delivery_app/constant/colors_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverTrackingScreen extends StatefulWidget {
  const DriverTrackingScreen({super.key});

  @override
  State<DriverTrackingScreen> createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [textcyanColor, textcyanColor.withOpacity(0.01)])),
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
                        // ignore: prefer_const_constructors
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
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
                  child: Image.asset(
                "assets/images/map_img.png",
                width: Get.width,
                fit: BoxFit.cover,
              ))
            ],
          ),
        ));
  }
}
