import 'package:cargo_delivery_app/alltrips/all_trip_page.dart';
import 'package:cargo_delivery_app/api/auth_controller.dart';
import 'package:cargo_delivery_app/home/riderrequest/rider_request_page.dart';
import 'package:cargo_delivery_app/notification/notifcation_page.dart';
import 'package:cargo_delivery_app/payment/payment_page.dart';
import 'package:cargo_delivery_app/profile/update_profile.dart';
import 'package:cargo_delivery_app/widgets/build_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constant/colors_utils.dart';
import '../home/controller/home_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.all(16.0.h),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: textBrownColor,
                    child: Image.asset(
                      'assets/images/profile.png',
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    Get.find<AuthController>().getLoginUserData()?.user?.name ??
                        '',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ListTile(
              onTap: () => Get.to(() => UpdateProfile()),
              dense: true,
              leading: Image.asset(
                'assets/images/profile_icon.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Profile'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () =>
                  Get.to(() => const DriverRequestNotificationScreen()),
              dense: true,
              leading: Image.asset(
                'assets/images/driver_way.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Near by drivers'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () => Get.to(() => const AllTripsPage()),
              dense: true,
              leading: Image.asset(
                'assets/images/driver_way.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Trips'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () => Get.to(() => const NotificationPage()),
              dense: true,
              leading: Image.asset(
                'assets/images/notification.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Notifications'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () => Get.to(() => const PaymentPage()),
              dense: true,
              leading: Image.asset(
                'assets/images/payment.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Payment'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () => buildDialog(
                  onTapOk: () {
                    Get.back();
                    Get.find<AuthController>().deleteAccount();
                  },
                  isDelete: true,
                  title: 'Delete Account'.tr,
                  subtitle:
                      'Are You Sure You Want To\n Delete Your Account?'.tr),
              dense: true,
              leading: Image.asset(
                'assets/images/deletacnt.png',
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Delete Account'.tr,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            const Divider(),
            const Spacer(),
            InkWell(
              onTap: () => buildDialog(
                  onTap: () async {
                    Get.back();
                  },
                  onTapOk: () async {
                    Get.back();
                    await Get.find<AuthController>().logout();
                    Get.delete<HomeController>();
                  },
                  isDelete: false,
                  title: 'Sign Out'.tr,
                  subtitle: 'Are You Sure You Want To\nSign Out?'.tr),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.logout), Text('Sign Out'.tr)],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
