import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constant/colors_utils.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final _nameController = TextEditingController(),
      _addressController = TextEditingController(),
      _emailController = TextEditingController(),
      _phoneController = TextEditingController(),
      _passwordController = TextEditingController(),
      _confirmPassController = TextEditingController();
  final _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.5, 0.5),
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1),
              textcyanColor.withOpacity(0.1)
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: buildBackButton(context, onTap: Get.back),
            ),
            CircleAvatar(
              backgroundColor: textBrownColor,
              radius: 80,
              child: Image.asset('assets/images/profile.png'),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController
                          ..text =
                              _controller.getLoginUserData()?.user?.name ?? '',
                        hintText: 'Abdullah',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _addressController
                          ..text = _controller
                                  .getLoginUserData()
                                  ?.user
                                  ?.streetAddress ??
                              '',
                        hintText: 'Address',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _phoneController
                          ..text =
                              _controller.getLoginUserData()?.user?.mobile ??
                                  '',
                        hintText: 'Phone Number',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _emailController
                          ..text =
                              _controller.getLoginUserData()?.user?.email ?? '',
                        hintText: 'Email',
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password'.tr,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _confirmPassController,
                        hintText: 'Confirm Password'.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.h),
              child: CustomButton(buttonText: 'Update'.tr, onPress: () {
                Get.find<AuthController>().updateUser(fullName: _nameController.text, mobileNumber: _phoneController.text, email: _emailController.text, street: _addressController.text);
              }),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
