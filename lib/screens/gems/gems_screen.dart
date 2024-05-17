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
  int _selectedIndex = 0;
  late GemsProvider provider;
  bool loading = true, loader = false, paginate = true;
  int limit = 12;
  int offset = 1;
  int page = 1;

  Future<void> pagination() async {
    String type = "";
    if (_selectedIndex == 0) {
      type = "all";
    } else if (_selectedIndex == 1) {
      type = "Spent";
    } else {
      type = "Earn";
    }

    if (!paginate) return;
    setState(() {
      loader = true;
    });
    await provider.getuserGems(offset, type).then((value) {
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
    pagination();
  }

  @override
  void dispose() {
    super.dispose();
    provider.userGems.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
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
