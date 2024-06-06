//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Local Imports
import 'package:playverse/screens/auth/signup_screen.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/screens/auth/login_screen.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/widgets/common/neo_pop_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GeneralColors.gradientBackgrounColor0,
              GeneralColors.gradientBackgrounColor1
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.40,
                      blurRadius: screenWidth * 0.300,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            Positioned(
              top: screenHeight - 100,
              left: screenWidth - 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.20,
                      blurRadius: screenWidth * 0.145,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      AuthScreenImages.logoImage,
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: screenHeight / 5,
                    ),
                    NeoPopButtonWidget(
                      text: "Login to PlayVerse",
                      navigation: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        )
                      },
                      textImage: AuthScreenImages.loginIcon,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    NeoPopButtonWidget(
                      text: "SignUp To PlayVerse",
                      navigation: () => {
                        HapticFeedback.vibrate(),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        ),
                      },
                      textImage: AuthScreenImages.registerImage,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
