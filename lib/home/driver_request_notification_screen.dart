import 'package:cargo_delivery_app/constant/colors_utils.dart';

import 'package:cargo_delivery_app/home/payment_screen.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverRequestNotificationScreen extends StatefulWidget {
  const DriverRequestNotificationScreen({super.key});

  @override
  State<DriverRequestNotificationScreen> createState() =>
      _DriverRequestNotificationScreenState();
}

class _DriverRequestNotificationScreenState
    extends State<DriverRequestNotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      requestAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              const Color(0xff113946),
              const Color(0xff113946).withOpacity(0.01),
            ],
          ),
        ),
        child: Scaffold(
            bottomSheet: Container(
              decoration: BoxDecoration(
                  color: curvedBlueColor.withOpacity(0.76),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: CustomButton(buttonText: "Proceed", onPress: () {}),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Column(
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
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                    child: Image.asset(
                  "assets/images/map_img.png",
                  width: Get.width,
                  fit: BoxFit.fill,
                ))
              ],
            )));
  }

  requestAlert() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Image.asset(
                  "assets/images/trruck_circular.png",
                  height: 44.h,
                  width: 44.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Your Request Sent',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: curvedBlueColor),
                ),
                SizedBox(height: 10.h),
                Text(
                  'We have sent your Delivery Request to your nearby diver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: curvedBlueColor),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  buttonText: "OK",
                  onPress: () {
                    Get.to(() => const PaymentScreen());
                  },
                  width: 97.w,
                  height: 38.h,
                )
              ],
            ),
          );
        });
  }
}
