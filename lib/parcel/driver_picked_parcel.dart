import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home/driver_tracking_screen.dart';

class ParcelPickPage extends StatelessWidget {
  const ParcelPickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.5, 0.5),
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1)
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: buildBackButton(context),
            ),
            SizedBox(
              height: 50.h,
            ),
            Text(
              'Driver Collected the Parcel',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: curvedBlueColor),
            ),
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Your parcel has been collected by the\t',
                  style: TextStyle(color: textBrownColor, fontSize: 15.sp),
                  children: [
                    TextSpan(
                        text: '\tMr. Ahmad ( Toyota X) \t',
                        style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                    TextSpan(
                        text:
                            '\the is on the way to your delivery location. we also sent a OTP link to receiver',
                        style:
                            TextStyle(color: textBrownColor, fontSize: 15.sp))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Divider(),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                height: 156.h,
                width: 327.w,
                decoration: BoxDecoration(
                    color: textBrownColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Shipping",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "ID: GJ012345",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff565359)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const DriverTrackingScreen());
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 36.h,
                                width: 102.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Track",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            decoration:
                                const BoxDecoration(color: Color(0xff4F4956)),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            decoration:
                                const BoxDecoration(color: Color(0xff4F4956)),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                              color: textBrownColor, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            decoration:
                                const BoxDecoration(color: Color(0xff4F4956)),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                              color: textBrownColor, shape: BoxShape.circle),
                        ),
                      ],
                    ),
                    Text(
                      "Madina",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
