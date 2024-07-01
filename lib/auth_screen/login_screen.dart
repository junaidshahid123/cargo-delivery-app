import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/auth_screen/forgot_password.dart';
import 'package:cargo_delivery_app/auth_screen/register_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/main.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _passwordController = TextEditingController(),
      _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var countryCode = Rx<String>('+966');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: const Alignment(1, -1.2), colors: [
            const Color(0xff113946),
            const Color(0xff113946).withOpacity(0.01),
          ]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      "hello again!".tr,
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: curvedBlueColor),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      "Fill Your Details or Continue with\n Social media".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: curvedBlueColor),
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Text(
                    "Mobile Number".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: textBrownColor),
                  ),
                  SizedBox(height: 10.h),
                  ContactField(
                    validator: (p0) {
                      if (p0!.length < 9) return 'Enter valid  phone number'.tr;
                      return null;
                    },
                    onchange: (value) {
                      countryCode.value = value;
                      return null;
                    },
                    controller: _mobileController,
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    "Password".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: textBrownColor),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    validator: (p0) {
                      if (p0!.isEmpty || p0.length < 6) {
                        return 'Enter 6 characters password'.tr;
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    maxLines: 1,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: Text(
                        'Forgot Password ?'.tr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: textBrownColor,
                            decorationColor: textBrownColor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  CustomButton(
                      buttonText: "Login".tr,
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          Get.find<AuthController>().login(
                              userType: '1',
                              fcmToken: fcmToken!,
                              password: _passwordController.text,
                              mobileNumber:
                                  countryCode + _mobileController.text);
                        }
                        return;
                        // Get.offAll(() => const LocationPage());
                      }),
                  SizedBox(height: 45.h),
                  InkWell(
                    onTap: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New User ?".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: textBrownColor),
                        ),
                        Text(
                          "Create Account".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff113946)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
