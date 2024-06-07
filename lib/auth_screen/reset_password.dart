import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final _passwordController = TextEditingController(),
      _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                'Reset Password'.tr,
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: textcyanColor),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
             Center(
              child: Text(
                'Please Enter Your New Password\n To Continue'.tr,
                style: TextStyle(fontFamily: ''),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.all(20.0.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        validator: (p0) {
                          if (p0!.isEmpty || p0.length < 6) {
                            return 'Enter 6 characters  password'.tr;
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: true,
                        hintText: 'New Password'.tr,
                        controller: _passwordController),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validator: (p0) {
                        if (p0!.isEmpty || p0 != _passwordController.text) {
                          return 'confirm password do not match'.tr;
                        }
                        return null;
                      },
                      maxLines: 1,
                      obscureText: true,
                      hintText: 'Confirm New Password'.tr,
                      controller: _confirmPassword,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                        buttonText: "Reset & Login".tr,
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            await Get.find<AuthController>().resetPassword(
                                password: _passwordController.text,
                                conformPassword: _confirmPassword.text);
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
