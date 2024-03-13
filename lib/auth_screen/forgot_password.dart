import 'dart:async';
import 'package:cargo_delivery_app/auth_screen/forgot_otp_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/back.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: lightBrownColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: curvedBlueColor),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          "Enter Your Mobile Number to reset\nYour Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: curvedBlueColor),
                        ),
                      ),
                      SizedBox(height: 100.h),
                      const ContactField(),
                      SizedBox(height: 25.h),
                      SizedBox(height: 25.h),
                      CustomButton(
                          buttonText: "Reset Password",
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  _timer =
                                      Timer(const Duration(seconds: 2), () {
                                    Navigator.of(context).pop();
                                    Get.to(() => const ForgotOtpScreen());
                                  });
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    insetPadding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    backgroundColor: Colors.white,
                                    title: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child:
                                                    const Icon(Icons.close))),
                                        SizedBox(height: 5.h),
                                        Image.asset(
                                          "assets/images/alert.png",
                                          height: 44.h,
                                          width: 44.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          'Check your Mobile',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: textBrownColor),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          'We have sent a password recovery code to your Mobile Number',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: textBrownColor),
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                                  );
                                }).then((val) {
                              if (_timer!.isActive) {
                                _timer!.cancel();
                              }
                            });
                          }),
                    ]),
              ),
            ),
          ),
        ));
  }
}
