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
            SizedBox(
              height: 50.h,
            ),
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
              height: 50.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Abdullah',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _addressController,
                      hintText: 'Address',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _confirmPassController,
                      hintText: 'Confirm Password',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.h),
              child: CustomButton(buttonText: 'Update', onPress: () {}),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}
