//Third Party Imports
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/repository/firebase_api.dart';
import 'package:playverse/screens/auth/login_screen.dart';
import 'package:playverse/screens/auth/signup_screen.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/widgets/common/neo_pop_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String? emailError;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              onChanged: (value) {
                                if (emailError != null) {
                                  setState(() => emailError = null);
                                }
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email";
                                }
                                return emailError;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Enter your Email',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    )
                                  },
                                  child: Text(
                                    'Login?',
                                    style: poppinsFonts.copyWith(
                                      color: GeneralColors.colorStyle0,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    NeoPopButtonWidget(
                      text: "Request an Reset",
                      navigation: () => {
                        if (_formKey.currentState!.validate()) {reset()}
                      },
                      textImage: AuthScreenImages.loginIcon,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "New to PlayVerse?",
                          style: poppinsFonts.copyWith(
                            color: GeneralColors.colorStyle0,
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            )
                          },
                          child: Text(
                            'Register',
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
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

  BuildContext? loaderCTX;
  Future<void> reset() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        loaderCTX = ctx;
        return Center(
          child: Image.asset(
            getRandomImage(),
          ),
        );
      },
    ).then((value) => loaderCTX = null);

    resetPassword(emailController.text).then((value) {
      if ([value.email].contains('success')) {
        if (loaderCTX != null) Navigator.pop(loaderCTX!);
        Navigator.pop(context);
      } else {
        if (loaderCTX != null) Navigator.pop(loaderCTX!);
        setState(() {
          emailError = value.email;
        });
      }
    });
  }
}
