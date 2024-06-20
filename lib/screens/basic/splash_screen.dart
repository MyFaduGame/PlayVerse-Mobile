//Third Party Imports
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/app.dart';
import 'package:playverse/screens/auth/auth_screen.dart';
import 'package:playverse/themes/app_font.dart';

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
      const Duration(seconds: 4),
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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF000019),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 20.0, height: 100.0),
            Text(
              'Play',
              style: horizonFonts.copyWith(
                fontSize: 25.0,
              ),
            ),
            DefaultTextStyle(
              style: horizonFonts.copyWith(
                fontSize: 20.0,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    ' Verse',
                    textStyle: horizonFonts.copyWith(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  TypewriterAnimatedText(
                    ' Compete',
                    textStyle: horizonFonts.copyWith(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  TypewriterAnimatedText(
                    ' Spectator',
                    textStyle: horizonFonts.copyWith(
                      color: Colors.purple,
                      fontSize: 20,
                    ),
                  ),
                  TypewriterAnimatedText(
                    ' Gear',
                    textStyle: horizonFonts.copyWith(
                      color: Colors.purpleAccent,
                      fontSize: 20,
                    ),
                  ),
                  TypewriterAnimatedText(
                    ' Group',
                    textStyle: horizonFonts.copyWith(
                      color: Colors.deepPurple,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
