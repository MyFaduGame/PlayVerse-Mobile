//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';

//Local Imports
import 'package:playverse/app.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/screens/auth/auth_screen.dart';
import 'package:playverse/screens/gems/gems_screen.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/repository/firebase_api.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class NavigationBarWidget extends StatefulWidget {
  final AdvancedDrawerController controller;
  final int index;
  final UserProfile userProfile;
  const NavigationBarWidget(
      {super.key,
      required this.controller,
      required this.index,
      required this.userProfile});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          // height: screenHeight - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.controller.hideDrawer();
                  tabManager.onTabChanged(5);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: widget.userProfile.profileImage == "" ||
                                  widget.userProfile.profileImage == null
                              ? widget.userProfile.gender == 'Male'
                                  ? SvgPicture.asset(
                                      ProfileImages.boyProfile,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      ProfileImages.girlProfile,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                              : CachedNetworkImage(
                                  imageUrl:
                                      widget.userProfile.profileImage ?? "",
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                        ),
                        Text(
                          widget.userProfile.userName ?? "",
                          style: poppinsFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.controller.hideDrawer();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const GemsScreen()),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: screenWidth / 10,
                            decoration: BoxDecoration(
                                color: const Color(0xFF231750),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  BottomAppBarImages.coinImage,
                                  height: screenWidth / 15,
                                  width: screenWidth / 15,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  widget.userProfile.gems.toString(),
                                  style: poppinsFonts.copyWith(
                                    color: const Color(0xFFBF99FF),
                                    fontSize: screenWidth / 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(9);
                          },
                          child: Container(
                            width: 100,
                            height: screenWidth / 10,
                            decoration: BoxDecoration(
                                color: const Color(0xFF231750),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Friends",
                                style: poppinsFonts.copyWith(
                                  color: const Color(0xFFBF99FF),
                                  fontSize: screenWidth / 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  widget.index == 0
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(0);
                            },
                            child: Text(
                              "Home",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(0);
                          },
                          child: Text(
                            "Home",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 1
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(1);
                            },
                            child: Text(
                              "Tournaments",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(1);
                          },
                          child: Text(
                            "Tournaments",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 2
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(2);
                            },
                            child: Text(
                              "Streams",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(2);
                          },
                          child: Text(
                            "Streams",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 6
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(6);
                            },
                            child: Text(
                              "History",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(6);
                          },
                          child: Text(
                            "History",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 7
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(7);
                            },
                            child: Text(
                              "Achievement",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(7);
                          },
                          child: Text(
                            "Achievement",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 10
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(10);
                            },
                            child: Text(
                              "Store",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(10);
                          },
                          child: Text(
                            "Store",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 3
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(3);
                            },
                            child: Text(
                              "Articles",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(3);
                          },
                          child: Text(
                            "Articles",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widget.index == 8
                      ? Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.purple,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.controller.hideDrawer();
                              tabManager.onTabChanged(8);
                            },
                            child: Text(
                              "Course",
                              style: dmSansFonts.copyWith(
                                fontSize: screenWidth / 20,
                                color: GeneralColors.generalTextColor,
                              ),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            widget.controller.hideDrawer();
                            tabManager.onTabChanged(8);
                          },
                          child: Text(
                            "Course",
                            style: dmSansFonts.copyWith(
                              fontSize: screenWidth / 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      logout(context);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: GeneralColors.gradientBackgrounColor0,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Log Out",
                          style: dmSansFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logout(context);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: GeneralColors.gradientBackgrounColor0,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Deactivate",
                          style: dmSansFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BuildContext? loaderCTX;
  Future<void> logout(BuildContext context) async {
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

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (loaderCTX != null) Navigator.pop(loaderCTX!);
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                if (loaderCTX != null) Navigator.pop(loaderCTX!);
                signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                    (route) => false,
                  );
                });
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
