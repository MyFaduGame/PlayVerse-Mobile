//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';
import 'package:playverse/provider/course_provider.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/games_model.dart';
import 'package:playverse/provider/games_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => CourseScreenState();
}

class CourseScreenState extends State<CourseScreen> {
  late GamesListProvider provider;
  late CourseProvider courseProvider;
  late UserProfileProvider profileProvider;
  UserProfile? userModel;
  List<Games>? gameModel;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationGames() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getGamesList(offsetUpcoming).then((value) {
      if (value < 12) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 12;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.gameList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<GamesListProvider>(context, listen: false);
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    paginationGames();
    profileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    profileProvider.getProfileInfoProvider().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userModel = context.select((UserProfileProvider value) => value.userModel);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Selector<GamesListProvider, List<Games>?>(
            selector: (p0, p1) => p1.gameList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationGames),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 9 / 16,
                  ),
                  clipBehavior: Clip.none,
                  itemCount: value?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        HapticFeedback.vibrate(),
                        courseProvider.register(
                          userModel?.email ?? "",
                          "I want to buy this course!",
                          value?[index].name ?? "",
                          userModel?.mobile ?? null.toString(),
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF7F00FF), Color(0xFF000000)]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: value?[index].thumbnail ?? "",
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.infinity,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Column(
                                children: [
                                  FittedBox(
                                    child: Text(
                                      "${value?[index].name}",
                                      style: openSansFonts.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SpacingUtils().horizontalSpacing(5),
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  color: TournamentWidgetColors
                                      .tournamentDetailCircleColor,
                                ),
                                child: Text(
                                  "Get Info",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
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
