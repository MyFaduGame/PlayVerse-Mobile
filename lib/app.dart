//Third Party Imports
// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playverse/screens/notification/notification_screen.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/screens/tournaments/winning_screen.dart';
import 'package:playverse/screens/store/store_screen.dart';
import 'package:playverse/screens/profile/friend_screen.dart';
import 'package:playverse/screens/achievements/achievements_screen.dart';
import 'package:playverse/screens/courses/course_screen.dart';
import 'package:playverse/screens/games/game_screen.dart';
import 'package:playverse/screens/profile/my_profile.dart';
import 'package:playverse/screens/tournaments/my_tournement_screen.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/screens/articles/articles_screen.dart';
import 'package:playverse/screens/home/home_screen.dart';
import 'package:playverse/screens/tournaments/tournament_screen.dart';
import 'package:playverse/screens/streams/streams_screen.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';
import 'package:playverse/models/user_status_model.dart';
import 'package:playverse/provider/user_status_provider.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/utils/tab_manager.dart';
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
  int bottomIndex = 0;
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
      const FriendScreen(), //9
      const StoreScreen(), //10
      const WinnerScreen(type: 'Solo'), // 11
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
    setState(() {
      myIndex = index;
    });
    userModel = context.select((UserProfileProvider value) => value.userModel);
    double screenWidth = MediaQuery.of(context).size.width;
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
          backgroundColor: const Color(0xFF000019),
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => tabManager.onTabChanged(5),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: userModel?.profileImage == "" ||
                          userModel?.profileImage == null
                      ? userModel?.gender == 'Male'
                          ? SvgPicture.asset(
                              ProfileImages.boyProfile,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              ProfileImages.girlProfile,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )
                      : CachedNetworkImage(
                          imageUrl: userModel?.profileImage ?? "",
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                          // placeholder: (context, url) =>
                          //     const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
              ),
            ),
            actions: [
              // index == 10
              //     ? Container(
              //         height: 40,
              //         width: screenWidth / 1.8,
              //         decoration: BoxDecoration(
              //           color: Colors.blueGrey,
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         child: TextField(
              //           decoration: InputDecoration(
              //             hintText: 'Find...!',
              //             hintStyle: poppinsFonts.copyWith(color: Colors.black),
              //             prefixIcon:
              //                 const Icon(Icons.search, color: Colors.black),
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       )
              //     : Container(),
              IconButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  ),
                },
                icon: const Icon(
                  FontAwesomeIcons.bell,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: const Icon(
                  Icons.menu,
                  size: 25,
                ),
              )
            ],
          ),
          body: screensList[index],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.shade900,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 25,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: bottomIndex,
            onTap: (value) => {
              setState(() {
                if (value == 0) {
                  onTabChanged(0);
                  bottomIndex = value;
                } // Home Page
                if (value == 1) {
                  onTabChanged(1);
                  bottomIndex = value;
                } // Tournaments Page
                if (value == 2) {
                  onTabChanged(2);
                  bottomIndex = value;
                } // Streams Page
                if (value == 3) {
                  onTabChanged(9);
                  bottomIndex = value;
                } // Friends Page
                if (value == 4) {
                  onTabChanged(10);
                  bottomIndex = value;
                } // Store Page
              })
            },
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                ),
                label: "",
                activeIcon: Icon(
                  FontAwesomeIcons.houseUser,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  BottomAppBarImages.tournamentImageUnFill,
                  color: Colors.grey,
                  height: 25,
                  width: 25,
                ),
                label: "",
                activeIcon: Image.asset(
                  BottomAppBarImages.tournamentImageFill,
                  color: Colors.white,
                  height: 25,
                  width: 25,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  BottomAppBarImages.streamUnFill,
                  color: Colors.grey,
                  height: 25,
                  width: 25,
                ),
                label: "",
                activeIcon: Image.asset(
                  BottomAppBarImages.streamFill,
                  color: Colors.white,
                  height: 25,
                  width: 25,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  BottomAppBarImages.friendsUnFill,
                  color: Colors.grey,
                  height: 25,
                  width: 25,
                ),
                label: "",
                activeIcon: Image.asset(
                  BottomAppBarImages.friendsFill,
                  color: Colors.white,
                  height: 25,
                  width: 25,
                ),
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.bagShopping,
                  color: Colors.grey,
                ),
                label: "",
                activeIcon: Icon(
                  FontAwesomeIcons.bagShopping,
                  color: Colors.white,
                ),
              ),
            ],
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
        if (index == 0) {
          // onTabChanged(0);
          bottomIndex = index;
        } // Home Page
        if (index == 1) {
          // onTabChanged(1);
          bottomIndex = index;
        } // Tournaments Page
        if (index == 2) {
          // onTabChanged(2);
          bottomIndex = index;
        } // Streams Page
        if (index == 3) {
          // onTabChanged(9);
          bottomIndex = index;
        } // Friends Page
        if (index == 4) {
          // onTabChanged(10);
          bottomIndex = index;
        } // Store Page
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

  void _handleMenuButtonPressed() {
    controller.showDrawer();
  }
}
