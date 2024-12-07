import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/auth_screen/login_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/contact_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _nameController = TextEditingController(),
      _passwordController = TextEditingController(),
      _phoneController = TextEditingController(),
      _emailController = TextEditingController(),
      _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var countryCode = Rx<String>('+996');
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
                child: Form(
                  key: _formKey,
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
                      SizedBox(height: 10.h),
                      Text(
                        "Sign Up".tr,
                        style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: curvedBlueColor),
                      ),
                      SizedBox(height: 90.h),
                      CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty || p0.length < 3) {
                            return 'Enter valid name'.tr;
                          }
                          return null;
                        },
                        controller: _nameController,
                        maxLines: 1,
                        hintText: "Full Name".tr,
                      ),
                      SizedBox(height: 20.h),
                      ContactField(
                        validator: (p0) {
                          if (p0!.length < 9) {
                            return 'Enter valid  phone number'.tr;
                          }
                          return null;
                        },
                        onchange: (value) {
                          countryCode.value = value;
                          return null;
                        },
                        controller: _phoneController,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        validator: (p0) {
                          if (!p0!.isEmail) {
                            return 'Enter valid email'.tr;
                          }
                          return null;
                        },
                        controller: _emailController,
                        maxLines: 1,
                        hintText: "Email".tr,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty || p0.length < 6) {
                            return 'Enter valid Password'.tr;
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        hintText: "Password".tr,
                        maxLines: 1,
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        validator: (p0) {
                          if (p0 != _passwordController.text) {
                            return 'Password do not match'.tr;
                          }
                          return null;
                        },
                        controller: _confirmPasswordController,
                        obscureText: true,
                        hintText: "Confirm Password".tr,
                        maxLines: 1,
                      ),
                      SizedBox(height: 55.h),
                      CustomButton(
                          buttonText: "Next".tr,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              await Get.find<AuthController>().registerUser(
                                  fullName: _nameController.text,
                                  mobileNumber:
                                      countryCode + _phoneController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  confirmPass: _confirmPasswordController.text);
                            }

                            // Get.to(() => const OtpScreen());
                          }),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account ?".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff113946)),
                          ),
                          InkWell(
                            onTap: () => Get.to(() => LoginScreen()),
                            child: Text(
                              "Log In".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: textBrownColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
