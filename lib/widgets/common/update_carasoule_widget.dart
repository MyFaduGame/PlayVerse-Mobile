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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Subscribe to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'GameNoShame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () =>
                    _openUrl("https://www.youtube.com/@gamenoshame/"),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                GeneralColors.sideEclipseColor,
                Colors.blueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enjoy Our',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Gaming Streams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => tabManager.onTabChanged(2),
                icon: const Icon(Icons.live_tv),
                label: const Text('Watch Now'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.purple,
                Colors.blueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Purchase Our',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Merchendize',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => tabManager.onTabChanged(10),
                icon: const Icon(Icons.trolley),
                label: const Text('Purchase'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
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
