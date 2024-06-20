//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Local Imports
import 'package:playverse/models/stores_model.dart';
import 'package:playverse/screens/store/cart_screen.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/widgets/common/store_widget.dart';

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
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF000019),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              ),
            },
            icon: const Icon(
              FontAwesomeIcons.cartPlus,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CarouselSlider(
                items: [
                  CachedNetworkImage(
                    imageUrl: widget.productDetail.images?[0] ?? "",
                    fit: BoxFit.fill,
                    height: 200,
                    width: double.infinity,
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl: widget.productDetail.images?[1] ?? "",
                    fit: BoxFit.fill,
                    height: 200,
                    width: double.infinity,
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                                color: const Color(0xFF2F4F4F),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              textAlign: TextAlign.center,
                              widget.productDetail.isActive == true
                                  ? "Available"
                                  : "Out of Stock",
                              style: poppinsFonts.copyWith(
                                color: Colors.blue.shade100,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(55),
                    child: CachedNetworkImage(
                      imageUrl: widget.productDetail.image ?? "",
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 1,
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.gem,
                                size: 20,
                                color: Colors.teal.shade400,
                              ),
                              Text(
                                widget.productDetail.price.toString(),
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Gem's Price",
                            style: poppinsFonts.copyWith(
                              color: const Color(0xFFBF99FF),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 50,
                      width: 1,
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.type_specimen,
                                size: 20,
                                color: Color(0xFFBF99FF),
                              ),
                              Text(
                                widget.productDetail.categoryName.toString(),
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Product Type",
                            style: poppinsFonts.copyWith(
                              color: const Color(0xFFBF99FF),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 50,
                      width: 1,
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.branding_watermark,
                                size: 20,
                                color: Colors.amber,
                              ),
                              Text(
                                widget.productDetail.brand ?? "Brand",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Brand",
                            style: poppinsFonts.copyWith(
                              color: const Color(0xFFBF99FF),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 1,
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: poppinsFonts.copyWith(
                  color: const Color(0xFFBF99FF),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.productDetail.description ?? "Description",
                textAlign: TextAlign.justify,
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 1,
              ),
              const SizedBox(height: 8),
              const NoramlHeaderWidget(
                  title: "Browser More", subTitle: "Products"),
              const SizedBox(height: 400, child: StoreWidget()),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () => {},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          width: screenWidth - 50,
          child: Center(
            child: Text(
              "Add to Cart",
              style: poppinsFonts.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
