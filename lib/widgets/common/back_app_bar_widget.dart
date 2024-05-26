//Third Party Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class BackAppBar extends StatefulWidget {
  const BackAppBar({
    super.key,
  });

  @override
  State<BackAppBar> createState() => _BackAppBarState();
}

class _BackAppBarState extends State<BackAppBar> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black38,
      ),
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      width: screenWidth,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(
              color: Colors.white,
              FontAwesomeIcons.arrowLeft,
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
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
