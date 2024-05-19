//Third party imports
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/box_indicator.dart';
import 'package:playverse/widgets/friends/friends_recommend_widget.dart';
import 'package:playverse/widgets/friends/friends_requests_widget.dart';
import 'package:playverse/widgets/friends/friends_status_widget.dart';
import 'package:playverse/widgets/friends/friends_widget.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 120),
                  FriendsStatusWidget(),
                ],
              ),
            ),
            SliverAppBar(
              clipBehavior: Clip.none,
              automaticallyImplyLeading: false,
              pinned: true,
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                  indicator: BoxIndicator(),
                  isScrollable: true,
                  unselectedLabelStyle: poppinsFonts.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  labelStyle: poppinsFonts.copyWith(
                    fontSize: 20,
                    color: Colors.yellow,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Friends',
                    ),
                    Tab(
                      text: 'Requests',
                    ),
                    Tab(
                      text: 'AddNew',
                    ),
                  ]),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            FriendsWidget(),
            FriendRequestScreen(),
            FriendsRecommendWidget(),
          ],
        ),
      ),
    );
  }
}
