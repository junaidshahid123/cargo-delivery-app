import 'dart:convert';
import 'package:cargo_delivery_app/bindings/controller_bindings.dart';
import 'package:cargo_delivery_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'fcm_handle.dart';
import 'localization_service.dart';
import 'localized_translations.dart';

void changeLanguage(String languageCode) {
  // Set the new language locale
  if (languageCode == "en") {
    LocalizationService.changeLocale(Locale('en'));
  } else if (languageCode == "ar") {
    LocalizationService.changeLocale(Locale('ar'));
  }
}

String? fcmToken;
// Variables to store token and expiry time in memory
String? accessToken;
DateTime? expiry;

Future<String?> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission to receive notifications
  await messaging.requestPermission();

  // Get the token
  String? token = await messaging.getToken();
  fcmToken = token;
  print('fcmToken==${fcmToken}');
  return token;
}

final _firebaseMessaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> initNotifications() async {
  await _firebaseMessaging.requestPermission();
  final fcmToken = await _firebaseMessaging.getToken();
  print('token=====${fcmToken}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await initNotifications();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await getFCMToken();
  await initServices(); // Initialize services

  runApp(
    CargoApp(),
  );
}

Future<void> initServices() async {
  await Get.putAsync(() async => await GetStorage.init());
  await Get.putAsync(() async => await LocalizationService.init());
}

class CargoApp extends StatefulWidget {
  const CargoApp({super.key});

  @override
  _CargoAppState createState() => _CargoAppState();
}

class _CargoAppState extends State<CargoApp> {
  final _messagingService = MessagingService();

  @override
  void initState() {
    // TODO: implement initState
    _messagingService.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return GetMaterialApp(
            translations: LocalizedTranslations(),
            // Use the wrapper class
            locale: Get.deviceLocale,
            // Set the default locale
            fallbackLocale: Locale('en'),
            supportedLocales: [Locale('en'), Locale('ar')],
            // Add localization delegates for handling Arabic translations
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialBinding: Binding(),
            initialRoute: '/',
            themeMode: ThemeMode.light,
            theme: ThemeData(
              fontFamily: 'RadioCanada',
            ),
            debugShowCheckedModeBanner: false,
            title: 'Cargo App',
            home: SplashScreen(),
          );
        });
  }
}
