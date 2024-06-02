//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

//Local Imports
import 'package:playverse/models/stores_model.dart';
import 'package:playverse/screens/store/cart_screen.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

class StoreDetailScreen extends StatefulWidget {
  final Products productDetail;
  const StoreDetailScreen({
    super.key,
    required this.productDetail,
  });

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  TextEditingController serachText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            const BackAppBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: screenWidth - 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F00FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  //TODO add serach bar
                  // child: SearchBar(
                  //   controller: serachText,
                  //   hintText: "Serach Products",

                  //   // backgroundColor: MaterialStateProperty.all(Colors.white)),
                  // ),
                  // child: Row(
                  //   children: [
                  //     const Icon(
                  //       Icons.search_sharp,
                  //       size: 35,
                  //       color: Colors.white,
                  //     ),
                  //     Text(
                  //       'Serach Products',
                  //       style: poppinsFonts.copyWith(
                  //         color: Colors.white,
                  //         fontSize: 20,
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF7F00FF),
                    ),
                    child: Image.asset(
                      BottomAppBarImages.cartImage,
                      height: 40,
                      width: 45,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              GeneralColors.gradientBackgrounColor0,
              GeneralColors.gradientBackgrounColor1
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.40,
                      blurRadius: screenWidth * 0.300,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            Positioned(
              top: screenHeight - 100,
              left: screenWidth - 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7F00FF).withOpacity(0.3),
                      spreadRadius: screenWidth * 0.20,
                      blurRadius: screenWidth * 0.145,
                    ),
                  ],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 200)),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 140),
                  CarouselSlider(
                    items: [
                      CachedNetworkImage(
                        imageUrl: widget.productDetail.images?[0] ?? "",
                        fit: BoxFit.fill,
                        height: 200,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.productDetail.images?[1] ?? "",
                        fit: BoxFit.fill,
                        height: 200,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 250,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      clipBehavior: Clip.none,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: widget.productDetail.image ?? "",
                          fit: BoxFit.cover,
                          height: 170,
                          width: 150,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: (screenWidth / 2) - 10,
                            child: FittedBox(
                              child: Text(
                                widget.productDetail.name ?? "Product Name",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF231750),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "${widget.productDetail.categoryName} ",
                                  style: poppinsFonts.copyWith(
                                    color: const Color(0xFFBF99FF),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.productDetail.description ?? "",
                    textAlign: TextAlign.justify,
                    style: poppinsFonts.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: screenWidth / 1.5,
                        child: NeoPopButton(
                          color: GeneralColors.neopopButtonMainColor,
                          bottomShadowColor: GeneralColors.neopopShadowColor,
                          onTapUp: () => {
                            HapticFeedback.vibrate(),
                            showCustomToast(
                              "Products Will be Availabe after 1-August-2024",
                            ),
                          },
                          child: const NeoPopShimmer(
                            shimmerColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add to Cart!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            BottomAppBarImages.coinImage,
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            '${widget.productDetail.price}',
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
