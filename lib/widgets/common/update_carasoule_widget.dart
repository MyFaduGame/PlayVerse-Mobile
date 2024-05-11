//Third Party Imports
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//Local Imports
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
        SizedBox(
          width: screenWidth,
          height: 200,
          child: Stack(
            children: <Widget>[
              Container(
                width: screenWidth,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white,
                  color: const Color.fromRGBO(127, 0, 255, 1),
                ),
              ),
              SvgPicture.asset(SvgIcons.xoButton),
              Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(
                  SvgIcons.vector1,
                  // semanticsLabel: 'vector1',
                ),
              ),
              Positioned(
                top: 0,
                left: 1,
                child: Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            UpdateScrollerWidgetImages.giveawayPhoto),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              const Positioned(
                top: 11.55419921875,
                left: 71.33451843261719,
                child: SizedBox(
                  width: 234.0973358154297,
                  height: 130.10989379882812,
                  child: Stack(children: <Widget>[
                    Positioned(
                      top: 27.629493713378906,
                      left: 0,
                      child: Text(
                        '+',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(106, 0, 213, 1),
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    Positioned(
                      top: 76.86024475097656,
                      left: 225.05487060546875,
                      child: Text(
                        '+',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(106, 0, 213, 1),
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 61.789527893066406,
                      child: Text(
                        '+',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(106, 0, 213, 1),
                            fontFamily: 'Poppins',
                            fontSize: 50,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    Positioned(
                      top: 109.01094818115234,
                      left: 62.291831970214844,
                      child: Text(
                        '+',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(106, 0, 213, 1),
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                    // Positioned(
                    //   top: 7.03296422958374,
                    //   left: 39.1834831237793,
                    //   child: Container(
                    //     width: 11.554160118103027,
                    //     height: 11.554160118103027,
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromRGBO(106, 0, 213, 1),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.elliptical(
                    //             11.554160118103027, 11.554160118103027),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 127.5981216430664,
                    //   left: 53.249656677246094,
                    //   child: Transform.rotate(
                    //     angle: -180 * (math.pi / 180),
                    //     child: Container(
                    //       width: 2.5117738246917725,
                    //       height: 2.5117738246917725,
                    //       decoration: const BoxDecoration(
                    //         color: Color.fromRGBO(106, 0, 213, 1),
                    //         borderRadius: BorderRadius.all(Radius.elliptical(
                    //             2.5117738246917725, 2.5117738246917725)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 40.690757751464844,
                    //   left: 43.70469284057617,
                    //   child: Container(
                    //     width: 5.52590274810791,
                    //     height: 5.52590274810791,
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromRGBO(106, 0, 213, 1),
                    //       borderRadius: BorderRadius.all(Radius.elliptical(
                    //           5.52590274810791, 5.52590274810791)),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 116.04397583007812,
                    //   left: 219.529052734375,
                    //   child: Container(
                    //     width: 5.52590274810791,
                    //     height: 5.52590274810791,
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromRGBO(106, 0, 213, 1),
                    //       borderRadius: BorderRadius.all(Radius.elliptical(
                    //           5.52590274810791, 5.52590274810791)),
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
              ),
              const Positioned(
                top: 47.22135543823242,
                left: 19.59174156188965,
                child: Text(
                  'Each Week We Host Super Cool \n Giveaways For Your Loyal Gamer’s',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
              Positioned(
                top: 88.6279296875,
                left: 19.591686248779297,
                child: SizedBox(
                  width: 65.3061752319336,
                  height: 38.46780014038086,
                  child: Stack(
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Positioned(
                          top: 1.2935791015625,
                          left: 0,
                          child: Container(
                            width: 65.30612182617188,
                            height: 14.065934181213379,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              color: Color.fromRGBO(188, 255, 0, 1),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          left: 2.408203125,
                          child: Text(
                            '+',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(127, 0, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                        const Positioned(
                          top: 3,
                          left: 11.408203125,
                          child: Text(
                            'Join Giveaway',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(127, 0, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 7,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                      ]),
                    ],
                  ),
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
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
