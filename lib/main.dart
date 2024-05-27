//Fastapi Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

//Local Imports
import 'package:playverse/provider/video_provider.dart';
import 'package:playverse/provider/course_provider.dart';
import 'package:playverse/provider/article_provider.dart';
import 'package:playverse/provider/gems_provider.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/provider/notifications_provider.dart';
import 'package:playverse/provider/achievements_provider.dart';
import 'package:playverse/provider/user_status_provider.dart';
import 'package:playverse/provider/friends_provider.dart';
import 'package:playverse/provider/games_provider.dart';
import 'package:playverse/provider/user_profile_provider.dart';
import 'package:playverse/provider/auth_provider.dart';
import 'package:playverse/screens/basic/splash_screen.dart';
import 'package:playverse/utils/push_notification.dart';
import 'package:playverse/utils/tab_manager.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();
late TabManager tabManager;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  PushNotification.initialize();

  PushNotification.showNotification(message, false);
  log("Handling a background message: ${message.messageId}");
  log('Message data: ${message.data}');
  if (message.notification != null) {
    log(
      'Message also contained a notification: ${message.notification?.body}',
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  /// FCM service starts from here
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  PushNotification.initialize();

  /// Permission request specially for ios devices and FCM token generation
  await messaging.requestPermission().then((value) {
    log(
      'requestPermission ${value.authorizationStatus.name} ${value.alert.name}',
    );
  });
  // await messaging.getToken().then((token) {
  //   log('FCM Token: $token');
  // });
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  /// Listens notification in background and terminated state
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Listens notification in foreground state
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    PushNotification.showNotification(message, true);
    log('Got a message while the app is running!');
    log('Message data: ${message.data}');
    if (message.notification != null) {
      log(
        'Message also contained a notification: ${message.notification?.body}',
      );
    }
  });

  log("FCMToken $fcmToken");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider(create: (context) => GamesListProvider()),
        ChangeNotifierProvider(create: (context) => FriendListProvider()),
        ChangeNotifierProvider(create: (context) => UserStatusProvider()),
        ChangeNotifierProvider(create: (context) => AchievementsProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => ArticlesProvider()),
        ChangeNotifierProvider(create: (context) => TournamentsProvider()),
        ChangeNotifierProvider(create: (context) => GamesListProvider()),
        ChangeNotifierProvider(create: (context) => GemsProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => VideoProvider()),
      ],
      child: MaterialApp(
        title: "GeNoS",
        scaffoldMessengerKey: messengerKey,
        home: const SplashScreen(),
        theme: ThemeData(
          useMaterial3: false,
        ),
      ),
    );
  }
}
