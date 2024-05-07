//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';

class CustomAppBar extends StatefulWidget {
  final AdvancedDrawerController controller;
  final String textToDisplay;
  const CustomAppBar({
    super.key,
    required this.textToDisplay,
    required this.controller,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: GeneralColors.sideEclipseColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.pink,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      width: screenWidth,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: screenWidth / 2,
          //   child: SearchBarAnimation(
          //     textEditingController: TextEditingController(),
          //     isOriginalAnimation: true,
          //     enableKeyboardFocus: true,
          //     hintText: "",
          //     onExpansionComplete: () {
          //       debugPrint('do something just after searchbox is opened.');
          //     },
          //     onCollapseComplete: () {
          //       debugPrint('do something just after searchbox is closed.');
          //     },
          //     onPressButton: (isSearchBarOpens) {
          //       debugPrint(
          //           'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
          //     },
          //     trailingWidget: Image.asset(AppBarImages().searchIconImage),
          //     secondaryButtonWidget: const Icon(
          //       Icons.close,
          //       size: 20,
          //       color: Colors.black,
          //     ),
          //     buttonWidget: Image.asset(
          //       AppBarImages().searchIconImage,
          //     ),
          //   ),
          ),
          GestureDetector(
            onTap: _handleMenuButtonPressed,
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth / 50,
              ),
              child: Text(
                widget.textToDisplay,
                style: gameOverFonts.copyWith(
                  fontSize: screenWidth / 20,
                  color: GeneralColors.generalTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
