import 'package:cargo_delivery_app/home/chat/chat_page.dart';
import 'package:cargo_delivery_app/home/delivery_details_screen.dart';
import 'package:cargo_delivery_app/home/home_screen.dart';
import 'package:cargo_delivery_app/home/more/more_view.dart';
import 'package:cargo_delivery_app/profile/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constant/colors_utils.dart';
import '../profile/profile_page.dart';
import 'orders/orders_view.dart';

class BottomBarScreen extends StatefulWidget {
  final int initialIndex; // Add this field to accept an initial index

  const BottomBarScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late int _currentIndex;

  final List<Widget> _pages = [
    HomeScreen(),
    OrdersView(),
    ChatPage(),
    WalletView(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Initialize _currentIndex with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: textcyanColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle:
        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
        const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            label: "Home".tr,
            icon: Image.asset(
              "assets/images/homeIcon.png",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Orders".tr,
            icon: Image.asset(
              "assets/images/oderImage.jpg",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Chat".tr,
            icon: Image.asset(
              "assets/images/chat_icon.png",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Wallet".tr,
            icon: Image.asset(
              "assets/images/walletIcon.jpg",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "More".tr,
            icon: Image.asset(
              "assets/images/moreImage.jpg",
              height: 30.h,
              width: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
