//Third Party Imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';

//Local Imports
import 'package:playverse/screens/profile/user_profile.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/models/friends_model.dart';
import 'package:playverse/provider/friends_provider.dart';

class FriendsRecommendWidget extends StatefulWidget {
  const FriendsRecommendWidget({super.key});

  @override
  State<FriendsRecommendWidget> createState() => _FriendsRecommendWidgetState();
}

class _FriendsRecommendWidgetState extends State<FriendsRecommendWidget> {
  late FriendListProvider provider;
  List<Friend>? friendModel;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationFriends() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
    });
    await provider.getFriendsProvider(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FriendListProvider>(context, listen: false);
    paginationFriends();
  }

  @override
  void dispose() {
    provider.recommendFriend.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Selector<FriendListProvider, List<Friend>?>(
      selector: (p0, p1) => p1.recommendFriend,
      builder: (context, value, child) {
        return value?.isEmpty ?? true
            ? Center(
                child: SizedBox(
                  width: screenWidth / 1.5,
                  child: const NeoPopShimmer(
                    shimmerColor: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        "Too Much Socialized!",
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
              )
            : NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationFriends),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  itemCount: value?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: (value?[index].profileImage == null)
                                ? "${value?[index].gender}" == 'Male'
                                    ? SvgPicture.asset(
                                        ProfileImages.boyProfile,
                                        height: 80,
                                      )
                                    : SvgPicture.asset(
                                        ProfileImages.girlProfile,
                                        height: 80,
                                      )
                                : Image.network(
                                    value?[index].profileImage ??
                                        "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww",
                                    height: 80,
                                  ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    "${value?[index].userName}",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "${value?[index].firstName ?? ""} ${value?[index].lastName ?? ""}",
                                    style: openSansFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 45,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6E17FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => UserProfileScreen(
                                        userId:
                                            value?[index].userId ?? "User Id",
                                      )),
                                ),
                              ),
                              color: Colors.white,
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
