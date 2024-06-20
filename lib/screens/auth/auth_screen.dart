//Third Party Imports
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/screens/auth/signup_screen.dart';
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
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF000019),
      body: Center(
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
    );
  }
}
