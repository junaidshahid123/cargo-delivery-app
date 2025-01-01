import 'dart:io';

import 'package:cargo_delivery_app/bindings/controller_bindings.dart';
import 'package:cargo_delivery_app/firebase_options.dart';
import 'package:cargo_delivery_app/home/chat/chat_page.dart';
import 'package:cargo_delivery_app/splash_screen.dart';
import 'package:cargo_delivery_app/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'api/auth_controller.dart';
import 'fcm_handle.dart';
import 'home/confirm_location_screen.dart';
import 'localization_service.dart';
import 'localized_translations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print("message.data: ${message.notification!.title}");
}

void changeLanguage(String languageCode) {
  // Set the new language locale
  if (languageCode == "en") {
    LocalizationService.changeLocale(const Locale('en'));
  } else if (languageCode == "ar") {
    LocalizationService.changeLocale(const Locale('ar'));
  }
}

String? fcmToken;
// Variables to store token and expiry time in memory
String? accessToken;
DateTime? expiry;

Future<String?> getFCMToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission to receive notifications
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get the token
      String? token = await messaging.getToken();
      if (token != null) {
        print('FCM Token: $token');
        return token;
      } else {
        print('Failed to retrieve FCM Token');
        return null;
      }
    } else {
      print('User denied notification permissions');
      return null;
    }
  } catch (e) {
    print('Error fetching FCM Token: $e');
    return null;
  }
}

final _firebaseMessaging = FirebaseMessaging.instance;

Future<void> initNotifications() async {
  if (Platform.isIOS) {
    print("Running on iOS platform");
    // Perform iOS-specific logic here
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      criticalAlert: true,
    );
    fcmToken = await _firebaseMessaging.getAPNSToken();
    print('iOS FCM Token: $fcmToken');
  } else if (Platform.isAndroid) {
    print("Running on Android platform");
    // Perform Android-specific logic here
    fcmToken = await _firebaseMessaging.getToken();
    print('Android FCM Token: $fcmToken');
  } else {
    print("Platform not supported");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Comment out additional initializations
  await initNotifications();
  await getFCMToken();
  await initServices();

  runApp(const CargoApp());
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
  RemoteMessage? _initialMessage;
  bool _isSplashDone = false;

  @override
  void initState() {
    // TODO: implement initState
    _messagingService.init(context);
    super.initState();
    _setupInteractedMessage();
  }

  void _handleMessage(RemoteMessage message) {
    // Navigate to the desired screen with the message data
    if (message.notification?.title == 'New Message') {
      Get.to(() => ChatPage(message: message));
    } else if (message.notification?.title == 'Accept Offer') {}
  }

  void _setupInteractedMessage() async {
    // Get the initial message
    _initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the initial message is not null, it means the app was opened via a notification
    if (_initialMessage != null) {
      _navigateToInitialRoute();
    }

    // Handle interaction when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message);
    });
  }

  void _navigateToInitialRoute() {
    if (_isSplashDone && _initialMessage != null) {
      _handleMessage(_initialMessage!);
    }
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
            fallbackLocale: const Locale('en'),
            supportedLocales: const [Locale('en'), Locale('ar')],
            // Add localization delegates for handling Arabic translations
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            initialBinding: Binding(),
            initialRoute: '/',
            getPages: [
              GetPage(
                  name: '/',
                  page: () => SplashScreen(onInitializationComplete: () {})),
              GetPage(
                  name: '/chatPage',
                  page: () => ChatPage(message: _initialMessage)),
            ],
            themeMode: ThemeMode.light,
            theme: ThemeData(
              fontFamily: 'RadioCanada',
            ),
            debugShowCheckedModeBanner: false,
            title: 'Cargo App',
            home: SplashScreen(
              onInitializationComplete: () {
                _isSplashDone = true;
                _navigateToInitialRoute();
                if (_initialMessage == null) {
                  Get.offAll(() => Get.find<AuthController>().isLogedIn()
                      ? LocationPage()
                      : const WelcomeScreen());
                }
              },
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Return the HttpClient with a bad certificate callback
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      // Log the certificate info for debugging
      print('SSL cert error: $cert');
      return true; // Allow all certificates for testing (not recommended for production)
    };
    return client;
  }
}
