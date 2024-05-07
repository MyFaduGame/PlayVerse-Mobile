//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/screens/auth/login_scree.n.dart';
import 'package:playverse/themes/app_images.dart';

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
        child: Center(
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
                SizedBox(
                  width: screenWidth / 1.5,
                  child: NeoPopButton(
                    color: GeneralColors.neopopButtonMainColor,
                    bottomShadowColor: GeneralColors.neopopShadowColor,
                    onTapUp: () => {
                      HapticFeedback.vibrate(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      )
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: NeoPopShimmer(
                      shimmerColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AuthScreenImages.controllerSmallImage),
                            const SizedBox(width: 5),
                            const Text(
                              "Login To PlayVerse",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: screenWidth / 1.5,
                  child: NeoPopButton(
                    color: GeneralColors.neopopButtonMainColor,
                    bottomShadowColor: GeneralColors.neopopShadowColor,
                    onTapUp: () => HapticFeedback.vibrate(),
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: NeoPopShimmer(
                      shimmerColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AuthScreenImages.controllerSmallImage),
                            const SizedBox(width: 5),
                            const Text(
                              "New to PlayVerse",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
