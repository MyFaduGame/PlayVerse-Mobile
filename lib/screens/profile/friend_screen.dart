//Third party imports
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/box_indicator.dart';
import 'package:playverse/widgets/friends/friend_request_sent_widget.dart';
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
      length: 4,
      child: NestedScrollView(
        clipBehavior: Clip.none,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  SizedBox(height: 100, child: FriendsStatusWidget()),
                ],
              ),
            ),
            SliverAppBar(
              clipBehavior: Clip.none,
              automaticallyImplyLeading: false,
              pinned: true,
              toolbarHeight: 80,
              backgroundColor: Colors.transparent,
              flexibleSpace: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Center(
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
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
                        text: ' My Friends ',
                      ),
                      Tab(
                        text: ' Sent Request ',
                      ),
                      Tab(
                        text: ' InComming ',
                      ),
                      Tab(
                        text: ' Add New ',
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
            FriendsWidget(),
            SentFriendRequests(),
            FriendRequestScreen(),
            FriendsRecommendWidget(),
          ],
        ),
      ),
    );
  }
}
