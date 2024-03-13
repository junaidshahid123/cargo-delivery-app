import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/driver_request_notification_screen.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  DateTimeRange? dateRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [textcyanColor, textcyanColor.withOpacity(0.1)])),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                "Add Your Details for delivery ",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: curvedBlueColor),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  pickDateRange(
                    context,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      height: 51.h,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              dateRange?.start != null
                                  ? DateFormat('dd/MM/yyy')
                                      .format(dateRange!.start)
                                  : "From",
                              style: TextStyle(
                                  fontSize: 16.sp, color: textBrownColor)),
                          Text("*",
                              style: TextStyle(
                                  fontSize: 16.sp, color: textBrownColor)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 51.h,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        dateRange?.end != null
                            ? DateFormat('dd/MM/yyy').format(dateRange!.end)
                            : "To",
                        style:
                            TextStyle(fontSize: 16.sp, color: textBrownColor)),
                    Text("*",
                        style:
                            TextStyle(fontSize: 16.sp, color: textBrownColor)),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              InkWell(
                onTap: () {},
                child: Text("Add Picture *",
                    style: TextStyle(fontSize: 16.sp, color: textBrownColor)),
              ),
              SizedBox(height: 10.h),
              Image.asset(
                "assets/images/add_pic.png",
                height: 51.h,
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: "Parcel Location",
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: "Receiver Location",
              ),
              SizedBox(height: 40.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: "Receiver Mobile",
              ),
              SizedBox(height: 40.h),
              CustomButton(
                  buttonText: "Submit",
                  onPress: () {
                    Get.to(() => const DriverRequestNotificationScreen());
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Future pickDateRange(
    context,
  ) async {
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime.now(),
        lastDate: DateTime(2300),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (newDateTimeRange != null) {
      dateRange = newDateTimeRange;
    }
  }
}
