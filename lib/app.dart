//Third Party Imports
// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:provider/provider.dart';

//Local Imports
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
      "Articles", //2
      "MVP's", //3
      "Live", //4
      "Friends", //5
      "Profile", //6
      "Teams", //7
      "Dare", //8
      "Dare", //9
      "Learn", //10
      "Visit",//ll
    ];
    screensList = [
    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  int index = 0;
  int myIndex = 0;
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
    setState(() {
      myIndex = index;
    });
    userModel = context.select((UserProfileProvider value) => value.userModel);
    // double screenWidth = MediaQuery.of(context).size.width;
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
        childBody: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient.lerp(
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  GeneralColors.sideEclipseColor,
                  GeneralColors.gradientBackgrounColor0,
                  GeneralColors.sideEclipseColor
                ]
              ),
              LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  GeneralColors.gradientBackgrounColor0,
                  GeneralColors.gradientBackgrounColor1
                ]
              ),
              0.0
            ),
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: CustomAppBar(
                textToDisplay: textList[index],
                controller: controller,
              ),
            ),
            body: screensList[index],
          ),
        ),
      ),
    );
  }

  @override
  void onTabChanged(int tabIndex,[String? id]) {
    // Future.delayed(Duration(milliseconds: 800)).then((value) => {});
    // Navigator.popUntil(context, ModalRoute.withName('/app'));
    if (mounted) {
      setState(() {
        index = tabIndex;
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
