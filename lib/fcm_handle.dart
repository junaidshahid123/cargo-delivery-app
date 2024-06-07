import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MessagingService {
  static String? fcmToken; // Variable to store the FCM token
  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init(BuildContext context) async {
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('Permission Allowed');
    } else {
      _fcm.requestPermission();
    }

    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');
    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();

    _fcm.getAPNSToken();
    log('fcmToken: $fcmToken');
    // Save FcmToken
    await SharedPreferences.getInstance()
        .then((value) => value.setString('fcm_token', fcmToken ?? ''));

    if (Platform.isIOS) {
      String? apnsToken = await _fcm.getAPNSToken();
      if (apnsToken != null) {
        await _fcm.subscribeToTopic('1313133');
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        apnsToken = await _fcm.getAPNSToken();
        if (apnsToken != null) {
          await _fcm.subscribeToTopic('1313133');
        }
      }
    } else {
      await _fcm.subscribeToTopic('1313133');
    }
    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');

      debugPrint('Message data: ${message.notification?.title.toString()}');
      if (message.notification != null) {
        if (message.notification?.title != null &&
            message.notification?.body != null) {
          // final notificationData = message.data;
          // final screen = notificationData['screen'];
          await _fcm.setForegroundNotificationPresentationOptions(
              alert: true, sound: true, badge: true);
          const AndroidNotificationChannel channel = AndroidNotificationChannel(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            description:
                'This channel is used for important notifications.', // description
            importance: Importance.max, playSound: true,
          );
          await _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel);
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (android != null) {
            _notificationsPlugin.show(
                notification.hashCode,
                notification?.title,
                notification?.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    icon: android.smallIcon,
                    // other properties...
                  ),
                ));
          }
        }
      }
    });

    LocalNoticationsService(_notificationsPlugin).init();
    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');

      _handleNotificationClick(context, message);
    });
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;
    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      Navigator.of(context).pushNamed(screen);
    }
  }
}

// Handler for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message: ${message.notification!.title}');
}

class LocalNoticationsService {
  LocalNoticationsService(
    this._notificationsPlugin,
  );
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher', // path to notification icon
    );

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      defaultPresentAlert: true,
      defaultPresentSound: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'category',
          options: {
            DarwinNotificationCategoryOption.allowAnnouncement,
          },
          actions: [
            DarwinNotificationAction.plain(
              'snoozeAction',
              'snooze',
            ),
            DarwinNotificationAction.plain(
              'confirmAction',
              'confirm',
              options: {
                DarwinNotificationActionOption.authenticationRequired,
              },
            ),
          ],
        ),
      ],
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectedNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotificationAction,
    );
    final notificationOnLaunchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationOnLaunchDetails?.didNotificationLaunchApp ?? false) {
      _onSelectedNotification(const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification));
    }
  }

  void _onSelectedNotification(NotificationResponse payload) {}
}

// Top level function
Future onSelectNotificationAction(details) async {
  final localNotificationsService =
      LocalNoticationsService(FlutterLocalNotificationsPlugin());
  await localNotificationsService.init();
}
