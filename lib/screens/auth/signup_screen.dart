//Third Party Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/neo_pop_widget.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/screens/auth/login_screen.dart';
import 'package:playverse/app.dart';
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
  late UserAuthProvider authProvider;
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController referCodeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String? emailError, passwordError;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<UserAuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    nameController.dispose();
    referCodeController.dispose();
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF000019),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: Form(
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
                        style: const TextStyle(color: Colors.white),
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
                        controller: userNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your UserName";
                          }
                          return emailError;
                        },
                        autocorrect: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Choose Your UserName',
                          hoverColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          if (passwordError != null) {
                            setState(() => passwordError = null);
                          }
                        },
                        controller: passwordController,
                        obscureText: showPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your PassKey";
                          }
                          return passwordError;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Enter your Passkey',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Re-Enter Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          if (passwordError != null) {
                            setState(() => passwordError = null);
                          }
                        },
                        obscureText: showPassword,
                        controller: rePasswordController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Re-Enter Your Pass Key";
                          }
                          return emailError;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Re-Enter your PassKey',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: const TextStyle(
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
                        style: const TextStyle(color: Colors.white),
                        controller: referCodeController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Enter your ReferCode',
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
              ),
              const SizedBox(
                height: 16,
              ),
              NeoPopButtonWidget(
                text: "SignUp To PlayVerse",
                navigation: () => {
                  if (_formKey.currentState!.validate()) {register()}
                },
                textImage: AuthScreenImages.registerImage,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already Have Account?",
                    style: poppinsFonts.copyWith(
                      color: GeneralColors.colorStyle0,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      )
                    },
                    child: Text(
                      'Login',
                      style: poppinsFonts.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BuildContext? loaderCTX;
  Future<void> register() async {
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

    signUpWithEmailPassword(emailController.text, passwordController.text,
            userNameController.text)
        .then((value) async {
      await authProvider
          .register(
        FirebaseAuth.instance.currentUser?.uid.toString() ?? "",
        userNameController.text,
        emailController.text,
        nameController.text,
        referCodeController.text.isNotEmpty ? referCodeController.text : null,
      )
          .then((values) {
        if (values == true) {
          if ([value.email, value.password].contains('success')) {
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
            setState(() {
              emailError = value.email;
              passwordError = value.password;
            });
          }
        } else {
          FirebaseAuth.instance.currentUser?.delete();
          if (loaderCTX != null) Navigator.pop(loaderCTX!);
        }
      });
    });
  }
}
