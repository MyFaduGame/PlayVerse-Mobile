//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/models/achievements_model.dart';
import 'package:playverse/provider/achievements_provider.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late AchievementsProvider provider;
  bool loading = true, loader = false, paginate = true;
  int limit = 12;
  int offset = 1;
  int page = 1;

  Future<void> pagination() async {
    if (!paginate) return;
    setState(() {
      loader = true;
    });
    await provider.getAllAchievements(offset).then((value) {
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
    provider = Provider.of<AchievementsProvider>(context, listen: false);
    pagination();
  }

  @override
  void dispose() {
    super.dispose();
    provider.allAchievements.clear();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<AchievementsProvider, List<Achievements>>(
            selector: (p0, p1) => p1.allAchievements,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, pagination),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _showInforamtion(context, value[index]),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                          ),
                          color: const Color(0xFF212838),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ColorFiltered(
                              colorFilter: value[index].added == true
                                  ? const ColorFilter.mode(
                                      Colors.transparent,
                                      BlendMode.multiply,
                                    )
                                  : const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.saturation,
                                    ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: value[index].added == true
                                        ? Colors.green
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: value[index].achievementsLogo == "NULL"
                                      ? SvgPicture.asset(
                                          SvgIcons.achievementIcon,
                                          fit: BoxFit.fill,
                                          color: Colors.red,
                                          height: 100,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              value[index].achievementsLogo ??
                                                  "",
                                          fit: BoxFit.fill,
                                          height: 100,
                                          // width: 1000,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                ),
                              ),
                            ),
                            Text(
                              value[index].achievementsTitle ?? "",
                              style: openSansFonts.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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

  void _showInforamtion(BuildContext context, Achievements data) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.pink,
          backgroundColor: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: screenHeight / 2,
                child: Column(
                  children: [
                    Text(
                      data.achievementsTitle ?? "",
                      style: poppinsFonts.copyWith(
                        fontSize: 70,
                      ),
                    ),
                    SpacingUtils().horizontalSpacing(10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: screenWidth / 2,
                      height: 2,
                    ),
                    SpacingUtils().horizontalSpacing(10),
                    CachedNetworkImage(
                      imageUrl: data.achievementsLogo == "NULL"
                          ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                          : data.achievementsLogo ?? "",
                      fit: BoxFit.cover,
                      height: screenHeight / 4,
                      // width: 1000,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    SpacingUtils().horizontalSpacing(16),
                    FittedBox(
                      child: Text(
                        "ID: ${data.achievementsId?.split('-').first}",
                        style: openSansFonts.copyWith(
                          color: Colors.blue[100],
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Type: ${data.achievementsType}",
                        style: openSansFonts.copyWith(
                          color: Colors.blue[100],
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Reward: +${data.xpReward}",
                        style: openSansFonts.copyWith(
                          color: Colors.blue[100],
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "Added: ${data.added}",
                        style: openSansFonts.copyWith(
                          color: Colors.blue[100],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
