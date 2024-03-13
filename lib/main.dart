import 'package:cargo_delivery_app/notification/notification_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    const CargoApp(),
  );
}

class CargoApp extends StatelessWidget {
  const CargoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return GetMaterialApp(
            initialRoute: '/',
            themeMode: ThemeMode.light,
            theme: ThemeData(
              fontFamily: 'RadioCanada',
            ),
            debugShowCheckedModeBanner: false,
            title: 'Cargo App',
            home: const NotificationSetting(),
          );
        });
  }
}
