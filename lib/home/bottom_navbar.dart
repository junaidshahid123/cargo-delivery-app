import 'package:cargo_delivery_app/home/chat/chat_page.dart';
import 'package:cargo_delivery_app/home/home_screen.dart';
import 'package:cargo_delivery_app/home/more/more_view.dart';
import 'package:cargo_delivery_app/profile/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constant/colors_utils.dart';
import '../model/MDCreateRequest.dart';
import '../profile/profile_page.dart';
import 'orders/orders_view.dart';

class BottomBarScreen extends StatefulWidget {
  final int initialIndex; // Accept an initial index

  const BottomBarScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late int _currentIndex;
  late PageController _pageController;

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
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
        physics: const BouncingScrollPhysics(), // Optional for bounce effect
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: textcyanColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
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
