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
import 'package:http/http.dart' as http;
import 'api/user_repo.dart';
import 'fcm_handle.dart';
import 'home/MySample.dart';
import 'home/controller/request_ridecontroller.dart';
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
const String serviceAccountJson = '''
  {
    "type": "service_account",
    "project_id": "cargo-delivery-app-4fbb8",
    "private_key_id": "d7ae181430917c1d1f4236891513ec83b3e9746e",
    "private_key": "BEGIN PRIVATE KEY" \nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCTpICnqydSq7/4\n5qmmaUouJLjMrSu42pLS4PQyApW9My1XsWw2MghdBcnXarjSf1L+I2CCZdFaAalQ\nuHprYNiq8voTutWAyA08haoadklX3DNdwyUDWut8Uy9K2IimFZ9VgUAKRJNFpHEN\nSqZdrf4kEMji9askq4y5WNrbKQ7FQKycHoITNk7y823XXEEvAfH38Y52UGvgiBAF\n9uTPQS22VUtDfdkioYxvKiCkH68fbWKAXsYOIb+fvqSF2Mg1BXoWURHsPzY3RymG\nlqxJ2TwBzEXPwfEuUsEdAgNDcKr3wGxPu99DP4/ZDqbepB5BuTmyO9UZfWZQOxm8\nwEeD4/6/AgMBAAECggEAGBhPNM3eX4QPEuhWBIYHaKtui1yxl3v4XTkAMU8xr8xz\n2G1oqxmUOtYwgBr3KcdEvJv6ap2CQo2l27oXpIGMKq33uROTN26ullN8FNB8HL4f\nlew8lKUYbFRJEg5vkqdRtwseb+6MGGADYTdvGjfEk483sa6FLTlgAHmrUfwL4I3z\nZtDlk6snIZ8qVJiiG7eIIsIAn79GSPxF1XkYUmwx/bqKdohLXShj7p6MXPElFw5V\n20+4ZJq/dVezrO27kV00bcstaXL+9hv6C5ZAgOfK8KLTn9h1UudSyBtP6NJjGNEw\nxVakhAJSbSOMpIixqIRIi+9tQ0ReAZZFCUDob5pmIQKBgQDPYFx2L/Z+av9wrK/4\nZjCqiQpo+nvGTWc7r6ZMmSlmaBywjgszpLtqe4zvu2el5yBSxIBmSd06hxS7SRTo\nsledn4RF2J4iSIYBfeKKabwaBNbd3nQc8L9nlpOFS0WYn+VBw/ixrcHnrYPrtUq/\nSOsLD1wE4dZXBFz4o5DBMESGIQKBgQC2Qqf7xAUqeS2K4Z+R3MzUofEO93JqYGJP\nDC1Lf4zGvrE70MaaHJiLUIgFTJa3obOvp3Aimq08P0FrzSISDzuQKIp90TLxFI/S\ncJmDnImQOU4aoKDL9lQh1FCYs7G4vIuIBkoOlYfXylE7VUMniF7ny2Kps2s9KFEx\n/wOD334o3wKBgC363KVr3wiKqtaNw3qdFd9KAV/jYfxG/0Oxn3rOXuqQ3QOciwlJ\nVjC28jnZYJLdW0JexWVorT+j4cng21z45gpR6x8dd3p8gBHmmos8BHP0bLvG7hHY\no2fRcCYW2XiMw2VAkWy77Ql0ZJKnoMom3c6W+j0u4bprgj2y7o6XKCphAoGBAIOU\nMZPn2tbj7sYRxtJV9iYX12C3sYkslix9HQIhTi95IZiOS6KcvF/vPpOczD475e4M\n0j6ZLjGNdRxvVoZ1KsoTCpB0g/NZpc8F7T3/t6xAQqukhRFafziA/8KOD+LPc2g7\nKiHHP+/Aps5P6pBSujlbMppS5jubrKqMcSw2H+0/AoGANhCWMpCNAS1ADvNfikJ6\nJfiKaKhWZeiBIftWsO02rGVsUz/keU/X/Cw6EG38J+nW/YsblMIQ6mDzCFTJ3pkO\nQFpWyJWfo6eep/yismdqitqGk86hdT4IuSlsVmufgGCSR3tPoZK56KPxIwKra2tI\nel82QfdNzRzvJSvXkmOxUus=\n "END PRIVATE KEY" \n",
    "client_email": "fcm-server@cargo-delivery-app-4fbb8.iam.gserviceaccount.com",
    "client_id": "106877443472198590115",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fcm-server%40cargo-delivery-app-4fbb8.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }

  ''';

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

Future<void> sendFCMMessage(
    String title, String body, String deviceToken) async {
  // Check if the token is expired or about to expire
  if (accessToken == null ||
      expiry == null ||
      DateTime.now().isAfter(expiry!.subtract(Duration(minutes: 5)))) {
    // await generateNewToken();
  }

  final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/cargo-delivery-app-4fbb8/messages:send');

  final message = {
    "message": {
      "token": deviceToken,
      "notification": {
        "title": title,
        "body": body,
      },
    },
  };

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer d7ae181430917c1d1f4236891513ec83b3e9746e',
    },
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('Message sent successfully: ${response.body}');
  } else {
    print('response.statusCode: ${response.statusCode}');
    print('Failed to send message: ${response.body}');
  }
}

class NotificationSender extends StatefulWidget {
  @override
  _NotificationSenderState createState() => _NotificationSenderState();
}

class _NotificationSenderState extends State<NotificationSender> {
  final String token =
      'e5qylVRZSpqnupgXcZDkyu:APA91bF_lTvwt-xqKQswo8nHnQGyjt1ge3zYAjdN1Ka3hCgcYi-vZo4rDLUmNeoGvv0u3jxP-OztfJyl2n7861YJvZ-fmmpkKjPKo70t2iaQRnGcQwgyfvcjwbyuhpZux9ZrAZxmfiU9';
  final String projectId = 'cargo-delivery-app-4fbb8';

  void sendNotification() async {
    const title = 'Test Notification';
    const body = 'This is a test notification';

    await sendFCMMessage(body, title, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send FCM Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendNotification,
          child: Text('Send Notification'),
        ),
      ),
    );
  }
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
