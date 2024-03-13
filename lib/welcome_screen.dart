import 'package:cargo_delivery_app/auth_screen/login_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            const Color(0xff113946),
            const Color(0xff113946).withOpacity(0.01),
          ]),
        ),
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
                Get.to(() => const LoginScreen());
              },
              child: Text(
                "Welcome",
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
    );
  }
}
