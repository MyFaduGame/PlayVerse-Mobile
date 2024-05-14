//Third Party Imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playverse/screens/streams/stream_watch_screen.dart';

//Local Imports
import 'package:playverse/widgets/common/update_carasoule_widget.dart';
import 'package:playverse/widgets/articles/article_list_widget.dart';
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/widgets/games/games_icon_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 120),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 120,
            ),
            const SizedBox(
              height: 200,
              child: UpdateCarsouleWidget(),
            ),
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StreamApp(),
                          )),
                    },
                icon: const Icon(FontAwesomeIcons.a)),
            const SizedBox(height: 16),
            const HeaderWidget(
                title: "Trending", subTitle: "Upcomming Matches", index: 1),
            const SizedBox(
              height: 600,
              child: TournamentListWidget(
                type: "Solo",
              ),
            ),
            const SizedBox(height: 16),
            const HeaderWidget(title: "Search by", subTitle: "Games", index: 4),
            const SizedBox(
              height: 150,
              child: GamesIconWidget(),
            ),
            const SizedBox(height: 16),
            const HeaderWidget(
              title: "Find Some",
              subTitle: "Articles",
              index: 3,
            ),
            const SizedBox(
              height: 200,
              child: ArticleWidget(),
            ),
            const HeaderWidget(
              title: "Dont Left",
              subTitle: "Streams",
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}
