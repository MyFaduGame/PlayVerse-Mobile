//Third Party Imports
// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playverse/screens/achievements/achievements_screen.dart';
import 'package:playverse/screens/courses/courser_screen.dart';
import 'package:playverse/screens/games/game_screen.dart';
import 'package:playverse/screens/profile/my_profile.dart';
import 'package:playverse/screens/tournaments/my_tournement_screen.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/screens/streams/streams_screen.dart';
import 'package:playverse/screens/articles/articles_screen.dart';
import 'package:playverse/screens/home/home_screen.dart';
import 'package:playverse/screens/tournaments/tournament_screen.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';
import 'package:playverse/models/user_status_model.dart';
import 'package:playverse/provider/user_status_provider.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/utils/tab_manager.dart';
import 'package:playverse/widgets/common/app_bar_widget.dart';
import 'package:playverse/widgets/common/navigation_drawer.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();
late TabManager tabManager;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>
    with WidgetsBindingObserver
    implements TabState {
  final AdvancedDrawerController controller = AdvancedDrawerController();
  String? id;
  late UserStatusProvider provider;
  late UserProfileProvider profileProvider;
  UserProfile? userModel;
  bool isLoading = true;
  List<UserStatus>? userStatusModel;
  AppLifecycleState? currentstate = SchedulerBinding.instance.lifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    profileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    profileProvider.getProfileInfoProvider().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    didChangeAppLifecycleState(currentstate ?? AppLifecycleState.hidden);
    FirebaseMessaging.instance.getToken().then((token) {
      log('FCM Token: $token');
    });
    myIndex = 0;
    tabManager = TabManager(this);
    textList = [
      "Games", //0
      "Matches", //1
      "Live", //2
      "Articles", //3
      "MVP's", //4
      "Friends", //5
      "Profile", //6
      "Teams", //7
      "Dare", //8
      "Dare", //9
      "Learn", //10
      "Visit", //ll
    ];
    screensList = [
      const HomeScreen(), //0
      const TournamentScreen(), //1
      const StreamsScreen(), //2
      const ArticleScreen(), //3
      const GamesScreen(), //4
      const MyProfileScreen(), //5
      const MyTournementsScreen(), //6
      const AchievementsScreen(), //7
      const CourseScreen(), //8
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  int index = 0;
  int myIndex = 0;
  int barIndex = 0;
  late List<Widget> screensList;
  late List<String> textList;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    provider = Provider.of<UserStatusProvider>(context, listen: false);
    log(state.toString(), name: "User state");
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      provider.userOwnStatus(false).then(
        (values) {
          log('false', name: "success");
        },
      );
      log('Its Offline', name: 'Backend API');
    } else {
      provider.userOwnStatus(true).then(
        (values) {
          log('true', name: "success");
        },
      );
      log('its online', name: 'log');
    }
  }

  @override
  Widget build(BuildContext context) {
    final NotchBottomBarController barController =
        NotchBottomBarController(index: barIndex);

    setState(() {
      myIndex = index;
    });
    userModel = context.select((UserProfileProvider value) => value.userModel);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (index != 0) {
          tabManager.onTabChanged(0);
          return false;
        }
        return true;
      },
      child: NavigationBarCustom(
        userProfile: userModel ?? UserProfile(),
        index: index,
        controller: controller,
        childBody: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: CustomAppBar(
              userProfile: userModel ?? UserProfile(),
              textToDisplay: textList[index],
              controller: controller,
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
                screensList[index]
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: AnimatedNotchBottomBar(
            color: GeneralColors.bottomNavColor,
            elevation: 1,
            showShadow: false,
            durationInMilliSeconds: 800,
            notchColor: GeneralColors.bottomBarNotchColor,
            notchBottomBarController: barController,
            bottomBarItems: [
              BottomBarItem(
                inActiveItem: SvgPicture.asset(
                  SvgIcons.homeIcon,
                  color: const Color(0xFF929292),
                ),
                activeItem: SvgPicture.asset(
                  SvgIcons.homeIcon,
                  color: Colors.white,
                ),
                itemLabel: '',
              ),
              BottomBarItem(
                inActiveItem: SvgPicture.asset(
                  SvgIcons.tournamentIcon,
                  color: const Color(0xFF929292),
                ),
                activeItem: SvgPicture.asset(
                  SvgIcons.tournamentIcon,
                  color: Colors.white,
                ),
                itemLabel: '',
              ),
              BottomBarItem(
                inActiveItem: Image.asset(
                  BottomAppBarImages.streamImage,
                  color: const Color(0xFF929292),
                ),
                activeItem: Image.asset(
                  BottomAppBarImages.streamSelectedImage,
                  color: Colors.white,
                ),
                itemLabel: '',
              ),
              BottomBarItem(
                inActiveItem: Image.asset(BottomAppBarImages.articleImage),
                activeItem:
                    Image.asset(BottomAppBarImages.articleSelectedImage),
                itemLabel: '',
              ),
            ],
            onTap: (index) {
              log(index.toString(), name: "index");
              tabManager.onTabChanged(index);
            },
            kIconSize: 24.0,
            kBottomRadius: 28.0,
          ),
        ),
      ),
    );
  }

  @override
  void onTabChanged(int tabIndex, [String? id]) {
    // Future.delayed(Duration(milliseconds: 800)).then((value) => {});
    // Navigator.popUntil(context, ModalRoute.withName('/app'));
    if (mounted) {
      setState(() {
        index = tabIndex;
        if (tabIndex >= 0 && tabIndex <= 3) {
          barIndex = tabIndex;
        } else {
          barIndex = 0;
        }
      });
    }
  }

  BuildContext? loaderCTX;
  void showDialouge(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        loaderCTX = ctx;
        return Center(
          child: Image.asset(
            getRandomLoaderImage(),
          ),
        );
      },
    ).then((value) => loaderCTX = null);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (loaderCTX != null) {
        Navigator.of(loaderCTX!).pop();
        loaderCTX = null;
      }
    });
  }
}
