//Third Party Imports
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
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
  TournamentDetail? tournamentDetail;
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
    provider.getTournamentsDetail(widget.tournamentID).then((value) {
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
    tournamentDetail =
        context.select((TournamentsProvider value) => value.tournamentDetail);
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
                padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Have to apply design
                          _buildWinnerWidget(
                              tournamentWinner?[1] ?? TournamentWinner(), 2),
                          _buildWinnerWidget(
                              tournamentWinner?[0] ?? TournamentWinner(), 1),
                          _buildWinnerWidget(
                              tournamentWinner?[2] ?? TournamentWinner(), 3),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: tournamentDetail?.logo ?? "",
                            fit: BoxFit.cover,
                            height: 170,
                            width: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              tournamentDetail?.title ?? "Game Name",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF231750),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    tournamentDetail?.gener ?? "genre",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 80,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF231750),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "${tournamentDetail?.registrationFee.toString()} Gems",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: screenWidth / 2,
                              child: NeoPopButton(
                                color: GeneralColors.neopopButtonMainColor,
                                bottomShadowColor:
                                    GeneralColors.neopopShadowColor,
                                onTapUp: () => {
                                  HapticFeedback.vibrate(),
                                },
                                child: const NeoPopShimmer(
                                  shimmerColor: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Watch Stream!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: TournamentDetialScreenColors
                                .tournamentContainerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                tournamentDetail?.maxPlayers.toString() ?? "",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Total Players",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: TournamentDetialScreenColors
                                .tournamentContainerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "${Random().nextInt(10)} K",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Total Watchers",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: TournamentDetialScreenColors
                                .tournamentContainerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "${tournamentDetail?.prizePool?.the1St ?? "0"} Gems",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "First Prize",
                                style: poppinsFonts.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Divider(
                      color: TournamentDetialScreenColors.dividerColor,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              "G ${tournamentDetail?.prizePool?.the1St}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              tournamentWinner?[0].userName ?? "First Prize",
                              style: poppinsFonts.copyWith(
                                color: Colors.green,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "G ${tournamentDetail?.prizePool?.the2nd}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              tournamentWinner?[1].userName ?? "Second Prize",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "G ${tournamentDetail?.prizePool?.the3rd}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              tournamentWinner?[2].userName ?? "Third Prize",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: TournamentDetialScreenColors.dividerColor,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerWidget(TournamentWinner winner, int rank) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: rank == 1 ? Colors.green : Colors.white,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(
                    75,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child:
                      winner.profileImage == null || winner.profileImage == ""
                          ? SvgPicture.asset(
                              ProfileImages.boyProfile,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: winner.profileImage == "" ||
                                      winner.profileImage == null
                                  ? "https://img.freepik.com/premium-vector/business-people-with-star-logo-template-icon-illustration-brand-identity-isolated-flat-illustration-vector-graphic_7109-1981.jpg"
                                  : winner.profileImage ?? "",
                              fit: BoxFit.cover,
                              height: 75,
                              width: 75,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                ),
              ),
              Text(
                winner.userName ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Rank $rank',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                'Score ${winner.totalScore}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(height: rank == 1 ? 50 : 0),
      ],
    );
  }
}
