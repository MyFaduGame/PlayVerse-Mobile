//Third Party Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/provider/auth_provider.dart';
import 'package:playverse/repository/firebase_api.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/loader_dialouge.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  late UserAuthProvider provider;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String? emailError, passwordError;

  @override
  void initState() {
    provider = Provider.of<UserAuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your First Name";
                          }
                          return emailError;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Enter your First Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 20),

                      //UserName
                      const Text(
                        'UserName',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your UserName";
                          }
                          return emailError;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Choose Your UserName',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 20),

                      //Email
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
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
                      const SizedBox(height: 20),

                      //Password
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (value) {
                          if (passwordError != null) {
                            setState(() => passwordError = null);
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your PassKey";
                          }
                          return passwordError;
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Enter your Passkey',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),

                      const Text(
                        'Re-Enter Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (value) {
                          if (passwordError != null) {
                            setState(() => passwordError = null);
                          }
                        },
                        obscureText: true,
                        controller: rePasswordController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Re-Enter Your Pass Key";
                          }
                          return emailError;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Re-Enter your PassKey',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 20),

                      //ReferCode
                      const Text(
                        'ReferCode',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (value) {
                          if (emailError != null) {
                            setState(() => emailError = null);
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your First Name";
                          }
                          return emailError;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Enter your First Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 20),
                    ],
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
                    onTapUp: () => {
                      HapticFeedback.vibrate(),
                      // if (_formKey.currentState!.validate()) {login()}
                    },
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
                              "Login to PlayVerse",
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

  BuildContext? loaderCTX;
  Future<void> login() async {
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

    signInWithEmailPassword(emailController.text, passwordController.text)
        .then((value) {
      if ([value.email, value.password].contains('success')) {
        provider
            .login(emailController.text,
                FirebaseAuth.instance.currentUser?.uid ?? "")
            .then(
          (values) {
            if (values == true) {
              if (loaderCTX != null) Navigator.pop(loaderCTX!);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const App(),
                  settings: const RouteSettings(name: '/app'),
                ),
                (route) => false,
              );
            } else {
              if (loaderCTX != null) Navigator.pop(loaderCTX!);
            }
          },
        );
      } else {
        if (loaderCTX != null) Navigator.pop(loaderCTX!);
        setState(() {
          emailError = value.email;
          passwordError = value.password;
        });
      }
    });
  }
}
