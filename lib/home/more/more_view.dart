import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/colors_utils.dart';
import '../bottom_navbar.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the home screen when the back button is pressed
        Get.offAll(() => const BottomBarScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: textcyanColor,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                        )),
                  ],
                ),
                Expanded(child: Container()),
                Center(
                  child: Text(
                    'No Wallet Yet'.tr,
                    style: TextStyle(color: backGroundColor),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
