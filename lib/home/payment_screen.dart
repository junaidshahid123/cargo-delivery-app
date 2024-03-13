import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/chat/chat_page.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      paymentRequestAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/back.png'),
          fit: BoxFit.fill,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Text(
                        "Driver Accepted Your Request",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: curvedBlueColor),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Center(
                      child: Text(
                        "Your Delivery Order has been\naccepted details are bellow:",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBrownColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      height: 1.h,
                      color: curvedBlueColor.withOpacity(0.37),
                    ),
                    Center(
                      child: Text(
                        "From Madina To Al-Ryadh \nin SAR 50",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: curvedBlueColor),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      height: 1.h,
                      color: curvedBlueColor.withOpacity(0.37),
                    ),
                    Text(
                      "Please select you payment Method",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: textBrownColor),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: "Enter Your Payment",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: "Bank Account/Card number",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: "Password",
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                        buttonText: "Proceed",
                        onPress: () {
                          Get.to(() => const ChatPage());
                        })
                  ]),
            ))));
  }

  paymentRequestAlert() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: const EdgeInsets.only(left: 10, right: 10, top: 70),
              backgroundColor: Colors.transparent,
              child: Column(
                children: List.generate(
                    3,
                    (index) => Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color(0xff5C5959),
                                          radius: 23.h,
                                          child: Image.asset(
                                            "assets/images/bus_icon.png",
                                            height: 23.h,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Vehicle  Name",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: curvedBlueColor),
                                            ),
                                            Text(
                                              "Driver name",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: curvedBlueColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "SAR 50",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: textBrownColor),
                                        ),
                                        Text(
                                          "5 min.",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: curvedBlueColor),
                                        ),
                                        Text(
                                          "3 Km",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: curvedBlueColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        borderRadius: 100,
                                        buttonColor: const Color(0xffF5F5F5),
                                        buttonTextColor:
                                            const Color(0xffCF442B),
                                        buttonText: "Decline",
                                        onPress: () {
                                          Get.back();
                                        },
                                        width: 145.w,
                                        height: 37.h,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: CustomButton(
                                        buttonColor: const Color(0xff03AB3C),
                                        buttonTextColor: Colors.white,
                                        borderRadius: 100,
                                        buttonText: "Accept",
                                        onPress: () {
                                          Get.back();
                                        },
                                        width: 145.w,
                                        height: 37.h,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
              ));
        });
  }
}
