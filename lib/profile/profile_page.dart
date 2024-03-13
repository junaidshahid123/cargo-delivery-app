import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors_utils.dart';

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
              padding: const EdgeInsets.all(8.0),
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
                    'Abdullah',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/images/profile_icon.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/images/driver_way.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Trips',
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/images/notification.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/images/payment.png',
                color: Colors.black,
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Payment',
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              dense: true,
              leading: Image.asset(
                'assets/images/deletacnt.png',
                height: 20.h,
                width: 20.h,
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            const Divider(),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.logout), Text('Sign Out')],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
