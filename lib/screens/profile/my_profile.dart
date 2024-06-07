//Third Party Imports
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/widgets/profile/about_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/friends/friends_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_profile_widget.dart';
import 'package:playverse/screens/profile/edit_profile.dart';
import 'package:playverse/widgets/profile/games_profile_widget.dart';
import 'package:playverse/screens/gems/gems_screen.dart';
import 'package:playverse/utils/box_indicator.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/provider/user_profile_provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late UserProfileProvider provider;
  UserProfile? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<UserProfileProvider>(context, listen: false);
    provider.getProfileInfoProvider().then((value) {
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
    userModel = context.select((UserProfileProvider value) => value.userModel);
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // const SizedBox(height: 80),
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
                                borderRadius: BorderRadius.circular(75),
                                child: userModel?.profileImage == null ||
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
                                        imageUrl: userModel?.profileImage ==
                                                    "" ||
                                                userModel?.profileImage == null
                                            ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                                            : userModel?.profileImage ?? "",
                                        fit: BoxFit.cover,
                                        height: 125,
                                        width: 125,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
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
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(55),
                                      ),
                                      height: 20,
                                      width: screenWidth - 200,
                                      child: LinearProgressIndicator(
                                        value: ((userModel?.expirence
                                                    ?.toDouble() ??
                                                10 * 100) /
                                            100),
                                        borderRadius: BorderRadius.circular(55),
                                        backgroundColor:
                                            const Color(0xFF231750),
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth - 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${((userModel?.expirence?.toDouble() ?? 10 * 100) / 100).toString()} Level",
                                            style: poppinsFonts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "${((userModel?.expirence?.toDouble() ?? 10 * 100)).toString()}%",
                                            style: poppinsFonts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Experience Point:${((userModel?.expirence?.toDouble() ?? 10 * 100) / 100)}",
                                  style: poppinsFonts.copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              "${userModel?.firstName ?? ""} ${userModel?.lastName ?? ""}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   "#${userModel?.userName ?? ''}",
                            //   style: poppinsFonts.copyWith(
                            //     color: Colors.white54,
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // Text(
                            //   "Nationality: ${userModel?.country ?? ''}",
                            //   style: poppinsFonts.copyWith(
                            //     color: Colors.white54,
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _openUrl(userModel?.instaURL),
                              child: Container(
                                height: 35,
                                width: screenWidth / 3.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFD6F2EA),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        ProfileScreenImages.instagram,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    Text(
                                      userModel?.instaURL ==
                                              "https://www.instagram.com/myfadugame"
                                          ? "Connect"
                                          : "DisConnnect",
                                      style: poppinsFonts.copyWith(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
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
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFD6F2EA),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      userModel?.fbURL ==
                                              "https://www.facebook.com/myfadugame"
                                          ? "Connect"
                                          : "DisConnnect",
                                      style: poppinsFonts.copyWith(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                          text: 'About',
                        ),
                        Tab(
                          text: 'Friends',
                        ),
                        Tab(
                          text: 'History',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              const GamesProfileWidget(),
              AboutWidget(userModel: userModel ?? UserProfile()),
              const FriendsWidget(),
              const TournamentProfileWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
