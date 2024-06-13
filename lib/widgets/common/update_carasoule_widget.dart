//Third Party Imports
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/app.dart';
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
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  UdpateImages.upgradePreminumImage,
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: TextButton(
                  onPressed: () => {tabManager.onTabChanged(10)},
                  child: Text(
                    "Get Preminum",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  UdpateImages.merchandizeImage,
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: TextButton(
                  onPressed: () => {tabManager.onTabChanged(10)},
                  child: Text(
                    "Buy Merchandize",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  UdpateImages.tournamentImage,
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: TextButton(
                  onPressed: () => {tabManager.onTabChanged(10)},
                  child: Text(
                    "Early Tournaments",
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
      options: CarouselOptions(
        height: 800,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
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
