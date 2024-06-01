//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playverse/screens/store/store_detail_screen.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/stores_model.dart';
import 'package:playverse/provider/store_provider.dart';

class StoreWidget extends StatefulWidget {
  const StoreWidget({super.key});

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  late StoreProvider provider;
  List<Products>? articlesList;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<StoreProvider>(context, listen: false);
    paginationArticles();
  }

  Future<void> paginationArticles() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getProducts(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.productList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<StoreProvider, List<Products>?>(
            selector: (p0, p1) => p1.productList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationArticles),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: value?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetailScreen(
                            productDetail: value![index],
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF7F00FF), Color(0xFF000000)]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CarouselSlider(
                              items: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: value?[index].images?[0] ?? "",
                                    // fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: value?[index].images?[1] ?? "",
                                    // fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                height: 100,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                clipBehavior: Clip.none,
                                autoPlay: false,
                                autoPlayInterval: const Duration(seconds: 2),
                                // autoPlayAnimationDuration:
                                // const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.easeIn.flipped,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            Text(
                              value?[index].name ?? "",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  BottomAppBarImages.coinImage,
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  value?[index].price ?? "",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
