import 'package:cargo_delivery_app/api/application_url.dart';
import 'package:cargo_delivery_app/api/user_repo.dart';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/controller/home_controller.dart';
import 'package:cargo_delivery_app/home/delivery_details_screen.dart';
import 'package:cargo_delivery_app/home/driver_tracking_screen.dart';
import 'package:cargo_delivery_app/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: GetX<HomeController>(
        init: HomeController(userRepo: UserRepo()),
        builder: (controller) => Scaffold(
            key: _key,
            drawer: Drawer(
              surfaceTintColor: textcyanColor,
              child: const ProfilePage(),
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [textcyanColor, Colors.white])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _key.currentState?.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            )),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.bannerModel.value?.banners?.length ?? 0,
                          (index) => Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                // height: 156.h,
                                width: 327.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Quick Delivery at\nyour Home ".tr,
                                      style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: textBrownColor),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                const DeliveryDetailsScreen());
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.all(5),
                                              height: 36.h,
                                              width: 103.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: textBrownColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "Book now".tr,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Builder(
                                            builder: (context) {
                                              final imageUrl =
                                                  "${ApplicationUrl.IMAGE_ULR}/images/${controller.bannerModel.value?.banners?[index].image}";
                                              print(
                                                  "Complete URL: $imageUrl"); // Prints the complete URL
                                              return Image.network(
                                                imageUrl,
                                                height: 72.h,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(Icons.error),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  (controller.dasboardModel.value?.currentRides.isEmpty ?? true)
                      ? Container(
                          margin: EdgeInsets.all(16.sp),
                          decoration: BoxDecoration(
                              color: curvedBlueColor,
                              borderRadius: BorderRadius.circular(20)),
                          height: 150.h,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'No Ride In progress'.tr,
                            style: TextStyle(color: Colors.white),
                          )),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 156.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.dasboardModel.value
                                      ?.currentRides.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final currentRide = controller
                                    .dasboardModel.value!.currentRides[index];
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    height: 156.h,
                                    width: 327.w,
                                    decoration: BoxDecoration(
                                      color: curvedBlueColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Current Shipping",
                                                  style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: textBrownColor,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "ID: ${currentRide.requestId}",
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  print(
                                                      'currentRide.requestId=======${currentRide.requestId}');

                                                  Get.to(() =>
                                                      DriverTrackingScreen(
                                                        requestId: currentRide
                                                            .requestId,
                                                      ));
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  height: 36.h,
                                                  width: 102.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: textBrownColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                    "Track",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 12.h,
                                              width: 12.w,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff4F4956),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: 12.w,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff4F4956),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: 12.w,
                                              decoration: BoxDecoration(
                                                color: textBrownColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 1.h,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff4F4956),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 12.h,
                                              width: 12.w,
                                              decoration: BoxDecoration(
                                                color: textBrownColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Expanded(
                                          child: Text(
                                            currentRide.request.parcelAddress
                                                        .length >
                                                    20
                                                ? "${currentRide.request.parcelAddress.substring(0, 20)}..."
                                                : "${currentRide.request.parcelAddress}",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Text(
                      "Quick another order".tr,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: curvedBlueColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/truck.png",
                            height: 102.h,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Truck".tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff575353)),
                          ),
                          Text(
                            "SAR 3.22/Km".tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: curvedBlueColor),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const DeliveryDetailsScreen());
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 36.h,
                                width: 103.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: textBrownColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Book now".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/car.png",
                            height: 102.h,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Car".tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff575353)),
                          ),
                          Text(
                            "SAR 3.22/Km".tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: curvedBlueColor),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const DeliveryDetailsScreen());
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 36.h,
                                width: 103.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: textBrownColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Book now".tr,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
