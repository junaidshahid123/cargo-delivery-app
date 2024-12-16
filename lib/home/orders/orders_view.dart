import 'package:cargo_delivery_app/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constant/colors_utils.dart';
import '../bottom_navbar.dart';
import 'orders_logic.dart';

import 'package:cargo_delivery_app/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constant/colors_utils.dart';
import '../bottom_navbar.dart';
import 'orders_logic.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersLogic>(
      init: OrdersLogic(),
      builder: (controller) {
        // Assuming allRidesData is a property of the controller
        final allRidesData =
            controller.allRidesData; // Replace with actual data source
        final isLoading = controller.isLoading.value;
        // print('controller.allRidesData=======${controller.allRidesData!.allRides![0].request!.parcelAddress}');

// Print the status of loading and the contents of allRidesData
        print('isLoading: $isLoading');
        if (allRidesData != null) {
          print('allRidesData: ${allRidesData.toString()}');
          // If allRidesData contains a list, print each ride's details
        } else {
          print('allRidesData is null');
        }
        // Add this if you're handling loading state

        return WillPopScope(
          onWillPop: () async {
            // Navigate to the home screen when the back button is pressed
            Get.offAll(() => const BottomBarScreen());
            return false; // Return false to prevent the default back button behavior
          },
          child: Scaffold(
            backgroundColor: textcyanColor,
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => const BottomBarScreen());
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            20), // Added space between back button and content

                    // Show a loading indicator if data is still being fetched
                    if (isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),

                    Expanded(
                      child: !isLoading &&
                          allRidesData != null &&
                          allRidesData.allRides!.isNotEmpty
                          ? ListView.builder(
                        itemCount: allRidesData.allRides!.length,
                        itemBuilder: (context, index) {
                          final ride = allRidesData.allRides![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                    () {
                                  switch (ride.status) {
                                    case '0':
                                      return 'status_pending'.tr;
                                    case '1':
                                      return 'status_processing'.tr;
                                    case '2':
                                      return 'status_cancel'.tr;
                                    case '3':
                                      return 'status_complete'.tr;
                                    case '4':
                                      return 'status_driver_done'.tr;
                                    default:
                                      return 'status_unknown'.tr;
                                  }
                                }(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black87, // Lighter text color
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'from'.tr}: ${ride.parcelAddress ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey, // Lighter text color
                                    ),
                                  ),


                                  Text(
                                    '${'to'.tr}: ${ride.receiverAddress ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey, // Lighter text color
                                    ),
                                  ),
                                  Text(
                                    '${'amount'.tr}: ${ride.amount ?? 'N/A'}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ),

                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: () {
                                // Handle ride tap action
                              },
                            ),
                          );
                        },
                      )
                          : Center(
                        child: Text(
                          'No Orders Yet'.tr,
                          style: TextStyle(
                            color: backGroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
