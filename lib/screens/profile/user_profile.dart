//Third Party Imports
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playverse/utils/box_indicator.dart';
import 'package:playverse/widgets/friends/friends_widget.dart';
import 'package:playverse/widgets/profile/games_profile_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/back_app_bar_widget.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/screens/profile/edit_profile.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfileProvider provider;
  UserProfileVisit? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.getUserProfileVisitProvider(widget.userId).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    userModel;
  }

  Future<void> _openUrl(urlLink) async {
    Uri userUrl = Uri.parse(urlLink);

    try {
      launchUrl(userUrl);
    } on Exception catch (e) {
      log(e.toString(), name: 'Url Exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    userModel =
        context.select((UserProfileProvider value) => value.userProfileVisit);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
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
            DefaultTabController(
                length: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const SizedBox(height: 100),
                              SizedBox(
                                height: 300,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      ProfileScreenImages.profileBanner,
                                      width: double.infinity,
                                      height: 250,
                                    ),
                                    Positioned(
                                      top: 150,
                                      left: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            75,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          child: userModel?.profileImage ==
                                                      null ||
                                                  userModel?.profileImage == ""
                                              ? userModel?.gender == 'Male'
                                                  ? SvgPicture.asset(
                                                      ProfileImages.boyProfile,
                                                      width: 125,
                                                      height: 125,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : SvgPicture.asset(
                                                      ProfileImages.girlProfile,
                                                      width: 125,
                                                      height: 125,
                                                      fit: BoxFit.cover,
                                                    )
                                              : CachedNetworkImage(
                                                  imageUrl: userModel
                                                                  ?.profileImage ==
                                                              "" ||
                                                          userModel
                                                                  ?.profileImage ==
                                                              null
                                                      ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                                                      : userModel
                                                              ?.profileImage ??
                                                          "",
                                                  fit: BoxFit.cover,
                                                  height: 125,
                                                  width: 125,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 225,
                                      right: 20,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                            ),
                                            height: 20,
                                            width: screenWidth - 200,
                                            child: LinearProgressIndicator(
                                              value: 0.4,
                                              borderRadius:
                                                  BorderRadius.circular(55),
                                              backgroundColor: Colors.grey[300],
                                              color: Colors.green,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Progress",
                                            style: poppinsFonts.copyWith(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(
                                        "${userModel?.firstName ?? ""} ${userModel?.lastName ?? ""}",
                                        style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "#${userModel?.userName ?? ''}",
                                        style: poppinsFonts.copyWith(
                                            color: Colors.white54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () =>
                                            _openUrl(userModel?.instaURL),
                                        child: Container(
                                          height: 35,
                                          width: screenWidth / 3.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFFD6F2EA),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.asset(
                                                  ProfileScreenImages.instagram,
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              Text(
                                                userModel?.instaURL ==
                                                        "https://www.instagram.com/myfadugame"
                                                    ? "Connected"
                                                    : "DisConnnected",
                                                style: poppinsFonts.copyWith(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      GestureDetector(
                                        onTap: () => _openUrl(userModel?.fbURL),
                                        child: Container(
                                          height: 35,
                                          width: screenWidth / 3.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color(0xFFD6F2EA),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                userModel?.fbURL ==
                                                        "https://www.facebook.com/myfadugame"
                                                    ? "Connected"
                                                    : "DisConnnected",
                                                style: poppinsFonts.copyWith(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.asset(
                                                  ProfileScreenImages.facebook,
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const EditProfileScreen()),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          //add or remove friend button
                                          'Nationality',
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          userModel?.country ?? "",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Experience',
                                        style: poppinsFonts.copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        userModel?.expirence.toString() ?? "",
                                        style: poppinsFonts.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "Your Informations",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        SliverAppBar(
                          clipBehavior: Clip.none,
                          automaticallyImplyLeading: false,
                          excludeHeaderSemantics: true,
                          pinned: true,
                          toolbarHeight: 0,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: PreferredSize(
                            preferredSize: const Size.fromHeight(0),
                            child: Center(
                              child: TabBar(
                                indicator: BoxIndicator(),
                                isScrollable: true,
                                unselectedLabelStyle: poppinsFonts.copyWith(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                                labelStyle: poppinsFonts.copyWith(
                                  fontSize: 24,
                                  color: Colors.yellow,
                                ),
                                tabs: const [
                                  Tab(
                                    text: 'Games',
                                  ),
                                  Tab(
                                    text: 'History',
                                  ),
                                  Tab(
                                    text: 'Friends',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: const TabBarView(
                      children: <Widget>[
                        GamesProfileWidget(),
                        SizedBox(child: TournamentProfileWidget()),
                        FriendsWidget(),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
