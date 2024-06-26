import 'dart:async';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        widget.onInitializationComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          const Color(0xff113946),
          const Color(0xff113946).withOpacity(0.01),
        ])),
        child: Center(
          child: Image.asset(
            "assets/images/splash_logo.png",
            height: 206.h,
            width: 206.w,
          ),
        ),
      ),
    );
  }
}
