import 'package:cargo_delivery_app/widgets/back_button_widget.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors_utils.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          children: [
            buildBackButton(context,
                title: 'Notification', isTitle: true, color: Colors.white),
            Container(
              margin: EdgeInsets.only(
                  top: 100.h, left: 10.h, right: 10.h, bottom: 20.h),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile.adaptive(
                        title: const Text('New Offers'),
                        value: true,
                        onChanged: (v) {}),
                    SwitchListTile.adaptive(
                        title: const Text('Announcements'),
                        value: true,
                        onChanged: (v) {}),
                    SwitchListTile.adaptive(
                        title: const Text('Account Updates'),
                        value: true,
                        onChanged: (v) {}),
                    SwitchListTile.adaptive(
                        title: const Text('Messages'),
                        value: true,
                        onChanged: (v) {}),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.h),
              child: CustomButton(buttonText: 'Save Now', onPress: () {}),
            )
          ],
        ),
      ),
    );
  }
}
