//Third Party Imports
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';

class UpdateCarsouleWidget extends StatefulWidget {
  const UpdateCarsouleWidget({super.key});

  @override
  State<UpdateCarsouleWidget> createState() => _UpdateCarsouleWidgetState();
}

class _UpdateCarsouleWidgetState extends State<UpdateCarsouleWidget> {
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
        // Container(
        //   color: const Color(0XFF8000FF),
        //   child: Text('Subscribe'),
        // ),
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
