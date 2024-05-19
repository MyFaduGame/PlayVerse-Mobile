//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/achievements_model.dart';
import 'package:playverse/provider/achievements_provider.dart';
import 'package:playverse/themes/app_font.dart';

class GamesProfileWidget extends StatefulWidget {
  const GamesProfileWidget({super.key});

  @override
  State<GamesProfileWidget> createState() => _GamesProfileWidgetState();
}

class _GamesProfileWidgetState extends State<GamesProfileWidget> {
  int achievementNumber = 0;
  late AchievementsProvider provider;
  List<Achievements>? userAchievements;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationAchievements() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getUserAchievements(offsetUpcoming).then((value) {
      if (value < 12) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 12;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.userAchievements.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AchievementsProvider>(context, listen: false);
    paginationAchievements();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Column(children: <Widget>[
      Text(
        "Achievements",
        style: poppinsFonts.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 100,
        width: screenWidth,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<AchievementsProvider, List<Achievements>?>(
                selector: (p0, p1) => p1.userAchievements,
                builder: (context, value, child) {
                  return value?.isEmpty ?? true
                      ? Center(
                          child: Container(
                            width: screenWidth / 2,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.pink[200],
                            ),
                            child: Text(
                              "You Might get Achievements!",
                              style: openSansFonts.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : NotificationListener(
                          onNotification: (notification) =>
                              Utils.scrollNotifier(
                                  notification, paginationAchievements),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: value?[index].achievementsLogo ==
                                              'NULL' ||
                                          value?[index].achievementsLogo == null
                                      ? SvgPicture.asset(
                                          SvgIcons.achievementIcon,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.red, BlendMode.color),
                                          height: 100,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              value?[index].achievementsLogo ??
                                                  "",
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
      ),
    ]);
  }
}
