//Third Party Imports
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playverse/app.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:url_launcher/url_launcher.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class UpdateCarsouleWidget extends StatefulWidget {
  const UpdateCarsouleWidget({super.key});

  @override
  State<UpdateCarsouleWidget> createState() => _UpdateCarsouleWidgetState();
}

class _UpdateCarsouleWidgetState extends State<UpdateCarsouleWidget> {
  Future<void> _openUrl(urlLink) async {
    Uri userUrl = Uri.parse(urlLink);

    try {
      launchUrl(userUrl);
    } on Exception catch (e) {
      log(e.toString(), name: 'Url Exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: [
        Container(
          color: const Color(0XFF8000FF),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image.asset(CarasouleSliderImages.giveAwayImage1),
              Image.asset(CarasouleSliderImages.giveAwayImage2),
              Positioned(
                left: 20,
                bottom: 0,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Each Week We Host Super Cool\nGiveaways For Your Loyal Gamer\'s',
                        style: poppinsFonts.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0XFFBDFF00),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          '+ Join Giveaway',
                          style: TextStyle(
                              color: Color(0XFF8000FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _openUrl("https://www.youtube.com/@gamenoshame/"),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 50.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Subscribe to our YouTube Channel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => tabManager.onTabChanged(2),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  GeneralColors.sideEclipseColor,
                  GeneralColors.neopopButtonMainColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  BottomAppBarImages.gameWall,
                  height: 125,
                  width: double.infinity,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Watch Latest Streams',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        clipBehavior: Clip.none,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
