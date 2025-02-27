import 'dart:io';
import 'package:cargo_delivery_app/api/api_constants.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/apputils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/colors_utils.dart';
import '../../model/MDCreateRequest.dart';
import '../../widgets/custom_button.dart';
import '../MySample.dart';
import '../bottom_navbar.dart';
import '../riderrequest/rider_request_page.dart';

class RequestRideController extends GetxController implements GetxService {
  final UserRepo userRepo;
  MDCreateRequest? mdCreateRequest;

  RequestRideController({required this.userRepo});

  createRideRequest({
    required List<File> image,
    required String parcel_city,
    required String parcelLat,
    required String category_id,
    required String delivery_date,
    required String parcelLong,
    required String parcel_address,
    required String from,
    required String to,
    // required String receiveLat,
    // required String receiverLong,
    // required String receiverAddress,
    required String receiverMob,
  }) async {
    var response = await userRepo.createRideRequest(
        image: image,
        parcelLat: parcelLat,
        parcelLong: parcelLong,
        parcellAddress: parcel_address,
        from:from,
        to:to,
        // receiveLat: receiveLat,
        // receiverLong: receiverLong,
        // receiverAddress: receiverAddress,
        receiverMob: receiverMob,
        category_id: category_id,
        delivery_date: delivery_date,
        parcel_city: parcel_city);
    if (response.containsKey(APIRESPONSE.SUCCESS)) {
      print('This is response In createRideRequest==========${response} ');
      mdCreateRequest = MDCreateRequest.fromJson(response);
      print(
          'This is mdCreateRequest==========${mdCreateRequest!.drivers!.length} ');
      requestAlert(mdCreateRequest!);
    } else {
      AppUtils.showDialog(response['message'], () => Get.back());
    }
  }
}

void requestAlert(mdCreateRequest) {
  showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          insetPadding: EdgeInsets.only(left: 20, right: 20),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Image.asset(
                "assets/images/trruck_circular.png",
                height: 44.h,
                width: 44.w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Request Sent'.tr,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: curvedBlueColor),
              ),
              SizedBox(height: 10.h),
              Text(
                'We have sent your Delivery Request to your nearby diver'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: curvedBlueColor),
              ),
              SizedBox(height: 20.h),

// Custom Button Code
              CustomButton(
                buttonText: "OK".tr,
                onPress: () async {
                  print('mdCreateRequest.drivers=${mdCreateRequest}');
                  print(
                      'mdCreateRequest!.request!.id!${mdCreateRequest!.request!.id!}');

                  // Extract the ID
                  int requestId = mdCreateRequest!.request!.id!;

                  // Store the ID in SharedPreferences
                  await storeRequestId(requestId);

                  // Example: Navigate to another screen or perform further actions
                  Get.offAll(BottomBarScreen());
                  // Get.to(() => DriverRequestNotificationScreen(mdCreateRequest: mdCreateRequest));
                },
                width: 97.w,
                height: 38.h,
              ),
            ],
          ),
        );
      });
}

// Function to store data in SharedPreferences
Future<void> storeRequestId(int requestId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('request_id', requestId);
  print('Request ID saved: $requestId');
}
