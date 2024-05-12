//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';

//Local Imports
import 'package:playverse/app.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class CustomAppBar extends StatefulWidget {
  final AdvancedDrawerController controller;
  final UserProfile userProfile;
  final String textToDisplay;
  const CustomAppBar({
    super.key,
    required this.textToDisplay,
    required this.controller,
    required this.userProfile,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      width: screenWidth,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => tabManager.onTabChanged(5),
            child: Container(
              width: 45.0,
              height: 45.0,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: widget.userProfile.profileImage == "" ||
                      widget.userProfile.profileImage == null
                  ? widget.userProfile.gender == 'Male'
                      ? SvgPicture.asset(
                          ProfileImages.boyProfile,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          ProfileImages.girlProfile,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        )
                  : CachedNetworkImage(
                      imageUrl: widget.userProfile.profileImage ?? "",
                      fit: BoxFit.cover,
                      height: 45,
                      width: 45,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  AppFileScreenImages.xoImage,
                  height: 25,
                  width: 25,
                ),
                const SizedBox(width: 5),
                Text(
                  "PlayVerse",
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: _handleMenuButtonPressed,
            child: SvgPicture.asset(
              SvgIcons.menuIcon,
              height: 25,
              width: 25,
              theme: const SvgTheme(
                currentColor: Colors.white,
              ),
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuButtonPressed() {
    widget.controller.showDrawer();
  }
}
