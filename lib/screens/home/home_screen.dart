//Third Party Imports
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/widgets/common/store_widget.dart';
import 'package:playverse/widgets/common/update_carasoule_widget.dart';
import 'package:playverse/widgets/articles/article_list_widget.dart';
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/widgets/courses/course_widget.dart';
import 'package:playverse/widgets/games/games_icon_widget.dart';
import 'package:playverse/widgets/streams/streams_widget.dart';
import 'package:playverse/widgets/tournaments/leaderboard_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            HeaderWidget(
                title: "Trending", subTitle: "Upcomming Matches", index: 1),
            SizedBox(
              height: 280,
              child: TournamentListWidget(
                type: "Solo",
              ),
            ),
            SizedBox(height: 8),
            HeaderWidget(title: "Search by", subTitle: "Games", index: 4),
            SizedBox(
              height: 100,
              child: GamesIconWidget(),
            ),
            SizedBox(height: 8),
            HeaderWidget(title: "Checkout", subTitle: "Updates", index: 1),
            SizedBox(
              height: 200,
              child: UpdateCarsouleWidget(),
            ),
            // SizedBox(height: 8),
            // HeaderWidget(
            //     title: "Checkout", subTitle: "Leaderboards", index: 11),
            // SizedBox(
            //   height: 300,
            //   child: LeaderBoardWidget(
            //     type: "Solo",
            //   ),
            // ),
            SizedBox(height: 8),
            HeaderWidget(
              title: "Dont Left",
              subTitle: "Streams",
              index: 2,
            ),
            SizedBox(
              height: 225,
              child: StreamsWidget(),
            ),
            SizedBox(height: 16),
            HeaderWidget(title: "REEDEME", subTitle: "Store", index: 10),
            SizedBox(
              height: 400,
              child: StoreWidget(),
            ),
            SizedBox(height: 16),
            HeaderWidget(
                title: "Get Trained", subTitle: "Latest Courses", index: 8),
            SizedBox(
              height: 200,
              child: CourseWidget(),
            ),
            SizedBox(height: 16),
            HeaderWidget(
              title: "Find Some",
              subTitle: "Articles",
              index: 3,
            ),
            SizedBox(
              height: 200,
              child: ArticleWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
