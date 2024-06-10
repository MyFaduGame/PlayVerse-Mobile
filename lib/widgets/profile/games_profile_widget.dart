//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/app.dart';
import 'package:playverse/provider/friends_provider.dart';
import 'package:playverse/models/friends_model.dart';
import 'package:playverse/provider/games_provider.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/games_model.dart';
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

  late GamesListProvider providerGames;
  List<Games>? gameModel;
  bool isLoadingGames = true;

  bool loadingGames = true, loaderGames = false, paginateUpcomingGames = true;
  int offsetUpcomingGames = 1;

  late FriendListProvider providerFriend;
  List<Friend>? friendModel;
  bool isLoadingFriend = true;

  bool loadingFriend = true,
      loaderFriend = false,
      paginateUpcomingFriend = true;
  int offsetUpcomingFriend = 1;

  Future<void> paginationGames() async {
    if (!paginateUpcomingGames) return;
    setState(() {
      loaderGames = true;
      isLoadingGames = false;
    });
    await providerGames.userGames(offsetUpcomingGames).then((value) {
      if (value < 12) paginateUpcomingGames = false;
      loaderGames = false;
      offsetUpcomingGames += 12;
      loadingGames = false;
      if (mounted) setState(() {});
    });
  }

  Future<void> paginationFriends() async {
    if (!paginateUpcomingFriend) return;
    setState(() {
      loaderFriend = true;
      isLoadingFriend = false;
    });
    await providerFriend
        .getOwnFriendsProvider(offsetUpcomingFriend)
        .then((value) {
      if (value < 10) paginateUpcomingFriend = false;
      loaderFriend = false;
      offsetUpcomingFriend += 10;
      loadingFriend = false;
      if (mounted) setState(() {});
    });
  }

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
    providerGames.userGameList.clear();
    providerFriend.ownFriend.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AchievementsProvider>(context, listen: false);
    providerGames = Provider.of<GamesListProvider>(context, listen: false);
    providerFriend = Provider.of<FriendListProvider>(context, listen: false);
    paginationAchievements();
    paginationGames();
    paginationFriends();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          const HeaderWidget(title: "Your", subTitle: "Games", index: 4),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            width: screenWidth,
            child: isLoadingGames
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Selector<GamesListProvider, List<Games>?>(
                    selector: (p0, p1) => p1.userGameList,
                    builder: (context, value, child) {
                      return value?.isEmpty ?? true
                          ? Center(
                              child: SizedBox(
                                width: screenWidth / 1.5,
                                child: NeoPopButton(
                                  color: GeneralColors.neopopButtonMainColor,
                                  bottomShadowColor:
                                      GeneralColors.neopopShadowColor,
                                  onTapUp: () => {tabManager.onTabChanged(4)},
                                  child: const NeoPopShimmer(
                                    shimmerColor: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text(
                                        "Add Some Games",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : NotificationListener(
                              onNotification: (notification) =>
                                  Utils.scrollNotifier(
                                      notification, paginationGames),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: value?[index].logo ==
                                                        'NULL' ||
                                                    value?[index].logo == null
                                                ? SvgPicture.asset(
                                                    SvgIcons.achievementIcon,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      Colors.red,
                                                      BlendMode.color,
                                                    ),
                                                    height: 50,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        value?[index].logo ??
                                                            "",
                                                    fit: BoxFit.fill,
                                                    height: 50,
                                                    width: 50,
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                getRandomColor()
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        Positioned(
                                          top: 120,
                                          child: SizedBox(
                                            width: 150,
                                            child: Column(
                                              children: [
                                                Text(
                                                  value?[index].name ??
                                                      "Game Name",
                                                  style: poppinsFonts.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "@${value?[index].inGameName}",
                                                  style: poppinsFonts.copyWith(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          const HeaderWidget(title: "Your", subTitle: "Achievements", index: 4),
          const SizedBox(height: 8),
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
                              child: SizedBox(
                                width: screenWidth / 1.5,
                                child: NeoPopButton(
                                  color: GeneralColors.neopopButtonMainColor,
                                  bottomShadowColor:
                                      GeneralColors.neopopShadowColor,
                                  onTapUp: () => {
                                    tabManager.onTabChanged(7),
                                  },
                                  child: const NeoPopShimmer(
                                    shimmerColor: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text(
                                        "You have Achievements!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: value?[index].achievementsLogo ==
                                                    'NULL' ||
                                                value?[index]
                                                        .achievementsLogo ==
                                                    null
                                            ? SvgPicture.asset(
                                                SvgIcons.achievementIcon,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Colors.red,
                                                  BlendMode.color,
                                                ),
                                                height: 50,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: value?[index]
                                                        .achievementsLogo ??
                                                    "",
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            "Friends",
            style: poppinsFonts.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            width: screenWidth,
            child: isLoadingFriend
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Selector<FriendListProvider, List<Friend>?>(
                    selector: (p0, p1) => p1.ownFriend,
                    builder: (context, value, child) {
                      return value?.isEmpty ?? true
                          ? Center(
                              child: SizedBox(
                                width: screenWidth / 1.5,
                                child: NeoPopButton(
                                  color: GeneralColors.neopopButtonMainColor,
                                  bottomShadowColor:
                                      GeneralColors.neopopShadowColor,
                                  onTapUp: () => {
                                    tabManager.onTabChanged(9),
                                  },
                                  child: const NeoPopShimmer(
                                    shimmerColor: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text(
                                        "Get Socialized!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : NotificationListener(
                              onNotification: (notification) =>
                                  Utils.scrollNotifier(
                                      notification, paginationFriends),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value?.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => tabManager.onTabChanged(9),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: (value?[index].profileImage ==
                                                  null)
                                              ? "${value?[index].gender}" ==
                                                      'Male'
                                                  ? SvgPicture.asset(
                                                      ProfileImages.boyProfile,
                                                      height: 100,
                                                    )
                                                  : SvgPicture.asset(
                                                      ProfileImages.girlProfile,
                                                      height: 100,
                                                    )
                                              : CachedNetworkImage(
                                                  imageUrl: value?[index]
                                                          .profileImage ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                  height: 50,
                                                  width: 50,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
