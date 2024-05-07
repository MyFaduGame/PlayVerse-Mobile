//Third Party Imports
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/app.dart';
import 'package:playverse/screens/auth/auth_screen.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.data != null) {
                  return const App();
                } else {
                  return const AuthScreen();
                }
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GeneralColors.gradientBackgrounColor0,
      body: Center(
        child: Image.asset(
          SplashScreenImages.splashScreen,
        ),
      ),
    );
  }
}
