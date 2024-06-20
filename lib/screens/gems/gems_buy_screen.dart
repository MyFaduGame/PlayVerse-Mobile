//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Local Imports
import 'package:playverse/models/gems_model.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

List<GemsInfo> gemsInfo = [
  GemsInfo(
    gemsAmount: 50,
    gemsPrize: 100,
  ),
  GemsInfo(
    gemsAmount: 100,
    gemsPrize: 200,
  ),
  GemsInfo(
    gemsAmount: 200,
    gemsPrize: 400,
  ),
  GemsInfo(
    gemsAmount: 500,
    gemsPrize: 1000,
  ),
  GemsInfo(
    gemsAmount: 1000,
    gemsPrize: 200,
  ),
  GemsInfo(
    gemsAmount: 1500,
    gemsPrize: 3000,
  ),
  GemsInfo(
    gemsAmount: 2000,
    gemsPrize: 4000,
  ),
];

class BuyGemsScreen extends StatefulWidget {
  const BuyGemsScreen({super.key});

  @override
  State<BuyGemsScreen> createState() => _BuyGemsScreenState();
}

class _BuyGemsScreenState extends State<BuyGemsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF000019),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 120),
              Text(
                "Gems Only",
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 12 / 9,
                  ),
                  itemCount: gemsInfo.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {HapticFeedback.vibrate()},
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF7F00FF), Color(0xFF000000)]),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  BottomAppBarImages.coinImage,
                                  height: 35,
                                  width: 35,
                                ),
                                Text(
                                  gemsInfo[index].gemsAmount.toString(),
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Rs. ${gemsInfo[index].gemsPrize}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Bundles",
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => {HapticFeedback.vibrate()},
                child: SizedBox(
                  height: 200,
                  width: screenWidth,
                  child: Image.asset(BundleImages.bundle1, fit: BoxFit.fill),
                ),
              ),
              GestureDetector(
                onTap: () => {HapticFeedback.vibrate()},
                child: SizedBox(
                  height: 200,
                  width: screenWidth,
                  child: Image.asset(
                    BundleImages.bundle2,
                    height: 100,
                    width: screenWidth,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
