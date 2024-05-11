//Third Party Imports
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Local Imports
import 'package:playverse/screens/notification/notification_screen.dart';
import 'package:playverse/utils/keys.dart';

class PushNotification {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  /// Initializing platform specific settings
  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log('Initialize payload ${details.payload}');
        log('navigatorKey.currentState ${Keys.navigatorKey.currentState?.mounted}');
        Keys.navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => const NotificationScreen()),
        );
      },
    );
  }

  /// Shows notification heads-up or banner
  static void showNotification(RemoteMessage message, bool opened) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (opened) {
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // importance: Importance.max,
          // priority: Priority.max,
        ),
        iOS: const DarwinNotificationDetails(),
      );
      _notification.show(
        DateTime.now().microsecond,
        message.notification?.title ?? 'Go To GeNoS!',
        message.notification?.body ?? 'Find Some Thing Exiting in out APP!',
        notificationDetails,
      );
    }
  }

  /// Gets message or data from notification after widget build is complete
  static Future<void> getNotificationMessage() async {
    /// Get any messages which caused the application to open froma terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    /// Also handle any interaction when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Handles operations to be done when app opens when user clicks on notification
  static void _handleMessage(RemoteMessage message) {
    log('_handleMessage ${message.data}');
    log('navigatorKey.currentState ${Keys.navigatorKey.currentState?.mounted}');
    Keys.navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => const NotificationScreen()),
    );
    // Do any task after receiving data
  }
}