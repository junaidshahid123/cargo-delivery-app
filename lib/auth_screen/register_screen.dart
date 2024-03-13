import 'package:cargo_delivery_app/auth_screen/login_screen.dart';
import 'package:cargo_delivery_app/auth_screen/otp_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                    SizedBox(height: 10.h),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: curvedBlueColor),
                    ),
                    SizedBox(height: 90.h),
                    CustomTextField(
                      controller: nameController,
                      maxLines: 1,
                      hintText: "Full Name",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: phoneController,
                      maxLines: 1,
                      hintText: "Phone",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: emailController,
                      maxLines: 1,
                      hintText: "Email",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: passwordController,
                      obscureText: true,
                      hintText: "Password",
                      maxLines: 1,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      hintText: "Confirm Password",
                      maxLines: 1,
                    ),
                    SizedBox(height: 55.h),
                    CustomButton(
                        buttonText: "Next",
                        onPress: () {
                          Get.to(() => const OtpScreen());
                        }),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff113946)),
                        ),
                        InkWell(
                          onTap: () => Get.to(() => const LoginScreen()),
                          child: Text(
                            "Log In",
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
        ));
  }
}
