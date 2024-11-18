import 'dart:convert';

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
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _passwordController = TextEditingController(),
      _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var countryCode = Rx<String>('+996');

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
                              userType: 1,
                              fcmToken: fcmToken!,
                              password: _passwordController.text,
                              mobileNumber:
                                  countryCode + _mobileController.text);
                          // onLoginTap();
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

  Future<void> onLoginTap() async {
    final url = Uri.parse('https://thardi.com/api/login');

    // Request Body
    Map<String, String> requestBody = {
      "mobile": '1',
      "password": '1',
      "device_token": fcmToken!,
      "user_type": '1',
    };

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    try {
      final client = http.Client();

      // Print request body and headers
      print('Request URL: $url');
      print('Request Headers: $headers');
      print('Request Body: $requestBody');

      // Sending the POST request
      final http.Response response = await client.post(
        url,
        headers: headers,
        body: requestBody,
      );

      // Print response status and body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');

        // Extract necessary details from the response
        String token = responseData['authorization']['token'] ?? '';
        String userName = responseData['user']['name'] ?? '';
        String userEmail = responseData['user']['email'] ?? '';
        String emailVerified = responseData['user']['email_verified_at'] ?? '';

        print('Token: $token');
        print('User Name: $userName');
        print('User Email: $userEmail');
        print('Email Verified At: $emailVerified');

        // Optionally navigate to the OTP verification screen
        Get.snackbar('Success', 'User Login successfully!',
            backgroundColor: Color(0xFFB7A06A), colorText: Colors.white);
        await Future.delayed(Duration(seconds: 3));
      } else {
        // Error case
        final Map<String, dynamic> responseData = json.decode(response.body);
        String errorMessage =
            responseData['message'] ?? 'Failed to register user';

        print('Error Message: $errorMessage');

        if (responseData.containsKey('errors')) {
          final errors = responseData['errors'] as Map<String, dynamic>;
          errors.forEach((key, value) {
            errorMessage += '\n${value.join(', ')}';
            print('Error Detail: $key -> ${value.join(', ')}');
          });
        }

        Get.snackbar('Error', errorMessage,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Catch any other errors
      print('Error occurred: $e');
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
