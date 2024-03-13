import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import 'otp_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
                size: 18,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: textcyanColor),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Center(
              child: Text(
                'Please Enter Your New Password\n To Continue ',
                style: TextStyle(fontFamily: ''),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.all(20.0.h),
              child: Column(
                children: [
                  CustomTextField(
                      maxLines: 1,
                      obscureText: true,
                      hintText: 'New Password',
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    maxLines: 1,
                    obscureText: true,
                    hintText: 'Confirm New Password',
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                      buttonText: "Reset&Login",
                      onPress: () {
                        Get.to(() => const OtpScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
