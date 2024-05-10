//Third Party Imports
import 'package:flutter/material.dart';
import 'package:playverse/widgets/common/update_carasoule_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_list_widget.dart';

//Local Imports

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
        padding: EdgeInsets.fromLTRB(10, 120, 10, 0),
        child: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 300,
            //   child: UpdateCarsouleWidget(),
            // ),
            SizedBox(
              height: 600,
              child: TournamentListWidget(
                type: "Solo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
