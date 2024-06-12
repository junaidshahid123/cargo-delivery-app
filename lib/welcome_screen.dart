import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/auth_screen/login_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/confirm_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              const Color(0xff113946),
              const Color(0xff113946).withOpacity(0.01),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row to hold language selection buttons at the top right corner
              Container(
                margin: EdgeInsets.only(top: 50,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Change language to English
                        // Add logic here to change the language to English
                        changeLanguage('en');
                      },
                      child: Text("en"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Change language to Arabic
                        // Add logic here to change the language to Arabic
                       changeLanguage('ar');

                      },
                      child: Text("عربى"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "طرد",
                        style: TextStyle(
                            fontSize: 50.sp,
                            fontFamily: 'RadioCanada',
                            color: textcyanColor,
                            fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          // Handle button tap logic
                          Get.to(() => Get.find<AuthController>().isLogedIn()
                              ? const LocationPage()
                              : LoginScreen());
                        },
                        child: Text(
                          "welcome".tr,
                          style: TextStyle(
                              fontSize: 31.sp,
                              fontFamily: 'RadioCanada',
                              color: textcyanColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}