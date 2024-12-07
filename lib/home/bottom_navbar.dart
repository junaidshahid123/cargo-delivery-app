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
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    OrdersView(),
    ChatPage(),
    WalletView(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: textcyanColor,
        // Color for selected item (icon + label)
        unselectedItemColor: Colors.grey,
        // Color for unselected items (icon + label)
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        // Label style for selected item
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        // Label style for unselected item
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        // Always show labels for selected item
        showUnselectedLabels: true,
        // Always show labels for unselected items
        items: [
          BottomNavigationBarItem(
            label: "Home".tr, // Label for Home tab
            icon: Image.asset(
              "assets/images/homeIcon.png",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Orders".tr, // Label for Orders tab
            icon: Image.asset(
              "assets/images/oderImage.jpg",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Chat".tr, // Label for Chat tab
            icon: Image.asset(
              "assets/images/chat_icon.png",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Wallet".tr, // Label for Profile tab
            icon: Image.asset(
              "assets/images/walletIcon.jpg",
              height: 30.h,
              width: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "More".tr, // Label for More tab
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
