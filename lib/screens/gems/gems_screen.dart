//Third Party Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/gems_model.dart';
import 'package:playverse/provider/gems_provider.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

class GemsScreen extends StatefulWidget {
  const GemsScreen({super.key});

  @override
  State<GemsScreen> createState() => _GemsScreenState();
}

class _GemsScreenState extends State<GemsScreen> {
  late GemsProvider provider;
  GemsData? gemsData;
  bool loading = true, loader = false, paginate = true;
  int limit = 12;
  int offset = 1;
  int page = 1;
  bool isLoading = true;

  Future<void> pagination() async {
    if (!paginate) return;
    setState(() {
      loader = true;
    });
    await provider.getuserGems(offset, 'all').then((value) {
      if (value < 12) paginate = false;
      loader = false;
      offset += limit;
      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<GemsProvider>(context, listen: false);
    provider.getUserGemsData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    pagination();
  }

  @override
  void dispose() {
    super.dispose();
    provider.userGems.clear();
  }

  @override
  Widget build(BuildContext context) {
    gemsData = context.select((GemsProvider value) => value.userGemsData);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(260),
        child: Column(
          children: [
            const BackAppBar(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF141326)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        BottomAppBarImages.coinImage,
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Earned',
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            gemsData?.earned.toString() ?? "0",
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.white,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Available',
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            gemsData?.total.toString() ?? "0",
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.white,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Spent',
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            gemsData?.spent.toString() ?? "0",
                            style: poppinsFonts.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF6E17FF),
                      ),
                      child: Center(
                        child: Text(
                          'Want to Buy More Gems?',
                          style: poppinsFonts.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
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
          children: [
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
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Selector<GemsProvider, List<Gems>>(
                    selector: (p0, p1) => p1.userGems,
                    builder: (context, value, child) {
                      return NotificationListener(
                        onNotification: (notification) =>
                            Utils.scrollNotifier(notification, pagination),
                        child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(10),
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF141326),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FittedBox(
                                    child: Text(
                                      value[index].title ?? "",
                                      style: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        BottomAppBarImages.coinImage,
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        value[index].gemAmount.toString(),
                                        style: poppinsFonts.copyWith(
                                          color: value[index].gemAmount! < 0
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
