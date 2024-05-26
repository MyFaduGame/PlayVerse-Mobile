//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

class LeaderBoardScreen extends StatefulWidget {
  final String tournamentID;
  const LeaderBoardScreen({super.key, required this.tournamentID});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  late TournamentsProvider provider;
  List<TournamentWinner>? tournamentWinner;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    provider.getTournamentWinner(widget.tournamentID).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tournamentWinner;
  }

  @override
  Widget build(BuildContext context) {
    tournamentWinner =
        context.select((TournamentsProvider value) => value.tournamentWinner);
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
          children: <Widget>[
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
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 110, 10, 0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildWinnerWidget(
                        tournamentWinner?[1] ?? TournamentWinner(), 2),
                    _buildWinnerWidget(
                        tournamentWinner?[0] ?? TournamentWinner(), 1),
                    _buildWinnerWidget(
                        tournamentWinner?[2] ?? TournamentWinner(), 3),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerWidget(TournamentWinner winner, int rank) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 40), // Space for floating profile picture
                  Text(
                    winner.userName ?? "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rank $rank',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
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
                  child:
                      winner?.profileImage == null || winner?.profileImage == ""
                          ? SvgPicture.asset(
                              ProfileImages.boyProfile,
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: winner?.profileImage == "" ||
                                      winner?.profileImage == null
                                  ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                                  : winner?.profileImage ?? "",
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
          ],
        ),
        SizedBox(height: rank == 1 ? 0 : 20),
      ],
    );
  }
}
