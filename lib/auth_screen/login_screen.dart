import 'package:cargo_delivery_app/auth_screen/forgot_password.dart';
import 'package:cargo_delivery_app/auth_screen/register_screen.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/bottom_navbar.dart';
import 'package:cargo_delivery_app/widgets/contact_field.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
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
                    "Hello Again!",
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: curvedBlueColor),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    "Fill Your Details or Continue with\n Social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: curvedBlueColor),
                  ),
                ),
                SizedBox(height: 100.h),
                Text(
                  "Mobile Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: textBrownColor),
                ),
                SizedBox(height: 10.h),
                const ContactField(),
                SizedBox(height: 25.h),
                Text(
                  "Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: textBrownColor),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: passwordController,
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
                      'ForgotPassword?',
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
                    buttonText: "Login",
                    onPress: () {
                      Get.offAll(() => const BottomBarScreen());
                    }),
                // SizedBox(height: 25.h),
                // InkWell(
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: MediaQuery.of(context).size.width,
                //     height: 55.h,
                //     padding: const EdgeInsets.only(left: 5, right: 5),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(13)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           "assets/images/google_icon.png",
                //           height: 22.h,
                //           width: 22.w,
                //         ),
                //         SizedBox(width: 10.w),
                //         Text("Sign In with Google",
                //             style: TextStyle(
                //                 fontSize: 14.sp,
                //                 fontWeight: FontWeight.w600,
                //                 color: textBrownColor)),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 45.h),
                InkWell(
                  onTap: () {
                    Get.to(() => const RegisterScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User?  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: textBrownColor),
                      ),
                      Text(
                        "Create Account",
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
    );
  }
}
