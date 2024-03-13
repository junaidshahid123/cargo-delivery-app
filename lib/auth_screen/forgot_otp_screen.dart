import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
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
                      children: [
                        const SizedBox(height: 30),
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
                        Center(
                          child: Text(
                            "OTP Verification",
                            style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: curvedBlueColor),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                            child: Text(
                          "Please Check Your Mobile \nto See The Verification Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: curvedBlueColor),
                        )),
                        SizedBox(height: 120.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "OTP Code",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: textBrownColor),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 47,
                          child: OtpTextField(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: textBrownColor),
                            showCursor: true,
                            filled: true,
                            fieldWidth: 46,
                            keyboardType: TextInputType.number,
                            numberOfFields: 5,
                            focusedBorderColor: Colors.white,
                            enabledBorderColor: Colors.white,
                            disabledBorderColor: Colors.white,
                            fillColor: Colors.white,
                            borderColor: Colors.white,

                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         title: const Text("Verification Code"),
                              //         content: Text(
                              //             'Code entered is $verificationCode'),
                              //       );
                              //     });
                            },
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomButton(buttonText: "Verify", onPress: () {}),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Resend code",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff113946)),
                            ),
                            Text(
                              "00:35",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff113946)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
