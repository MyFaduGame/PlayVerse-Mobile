//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/screens/tournaments/leaderboard_screen.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';
import 'package:playverse/themes/app_color_theme.dart';

class TournamentDetailScreen extends StatefulWidget {
  final TournamentDetail tournamentDetail;
  const TournamentDetailScreen({super.key, required this.tournamentDetail});

  @override
  State<TournamentDetailScreen> createState() => TournamentDetailScreenState();
}

class TournamentDetailScreenState extends State<TournamentDetailScreen> {
  late TournamentsProvider provider;
  TournamentDetail? tournamentDetail;
  bool isLoading = true;
  PrizePool? prizePool;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    // provider.getTournamentsDetail(widget.tournamentID).then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    prizePool = widget.tournamentDetail.prizePool ?? PrizePool();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // tournamentDetail =
    //     context.select((TournamentsProvider value) => value.tournamentDetail);
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 110, 10, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: widget.tournamentDetail.thumbnail ?? "",
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: widget.tournamentDetail.logo ?? "",
                                fit: BoxFit.fill,
                                height: 125,
                                width: 125,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                    widget.tournamentDetail.title ??
                                        "Game Name",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF231750),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        widget.tournamentDetail.gener ??
                                            "genre",
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "${widget.tournamentDetail.registrationFee.toString()} Gems",
                                        style: poppinsFonts.copyWith(
                                          color: const Color(0xFFBF99FF),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                widget.tournamentDetail.tournamentDate!
                                        .isBefore(DateTime.now())
                                    ? SizedBox(
                                        width: screenWidth / 2,
                                        child: NeoPopButton(
                                          color: GeneralColors
                                              .neopopButtonMainColor,
                                          bottomShadowColor:
                                              GeneralColors.neopopShadowColor,
                                          onTapUp: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    LeaderBoardScreen(
                                                        tournamentID: widget
                                                                .tournamentDetail
                                                                .tournamentId ??
                                                            "")),
                                              ),
                                            ),
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
                                                    "Show Leadberboard!",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: screenWidth / 2,
                                        child: NeoPopButton(
                                          color: widget.tournamentDetail
                                                      .registrationId ==
                                                  null
                                              ? GeneralColors
                                                  .neopopButtonMainColor
                                              : Colors.grey,
                                          bottomShadowColor:
                                              GeneralColors.neopopShadowColor,
                                          onTapUp: () => {
                                            checkRegistration(
                                                widget.tournamentDetail
                                                        .tournamentId ??
                                                    "",
                                                widget.tournamentDetail
                                                        .registrationId ??
                                                    "null")
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
                                                    "Join Tournament!",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    widget.tournamentDetail.maxPlayers
                                        .toString(),
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Total Players",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    widget.tournamentDetail.playerLeft
                                                .toString() ==
                                            "null"
                                        ? "All"
                                        : widget.tournamentDetail.playerLeft
                                            .toString(),
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Players Left",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "${widget.tournamentDetail.prizePool?.the1St ?? "0"} Gems",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "First Prize",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.white,
                              ],
                              begin: Alignment.center,
                              tileMode: TileMode.mirror,
                            ),
                          ),
                          width: double.infinity,
                          height: 2,
                        ),
                        const SizedBox(height: 8),
                        Table(
                          children: <TableRow>[
                            TableRow(
                              children: <TableCell>[
                                TableCell(
                                  child: Text(
                                    "Match Date:",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    DateFormat('dd-MMMM-yyyy').format(
                                      tournamentDetail?.tournamentDate ??
                                          DateTime.now(),
                                    ),
                                    style: poppinsFonts.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            TableRow(
                              children: <TableCell>[
                                TableCell(
                                  child: Text(
                                    "Entry Close:",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Text(
                                    DateFormat('dd-MMMM-yyyy').format(
                                      tournamentDetail?.registrationClose ??
                                          DateTime.now(),
                                    ),
                                    style: poppinsFonts.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            TableRow(
                              children: <TableCell>[
                                TableCell(
                                  child: Text(
                                    "Invitation:",
                                    style: poppinsFonts.copyWith(
                                      color: const Color(0xFFBF99FF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text: tournamentDetail
                                                    ?.invitationCode ??
                                                "N/A"),
                                      ).then(
                                        (value) => showCustomToast(
                                            "Copied to ClipBoard"),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          tournamentDetail?.invitationCode ??
                                              "N/A",
                                          style: poppinsFonts.copyWith(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.white,
                              ],
                              begin: Alignment.center,
                              tileMode: TileMode.mirror,
                            ),
                          ),
                          width: double.infinity,
                          height: 2,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          getRandomDescription(),
                          maxLines: 5,
                          style: poppinsFonts.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
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
                                  "G ${widget.tournamentDetail.prizePool?.the1St}",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
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
                            Column(
                              children: [
                                Text(
                                  "G ${widget.tournamentDetail.prizePool?.the2nd}",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "Second Prize",
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
                                  "G ${widget.tournamentDetail.prizePool?.the3rd}",
                                  style: poppinsFonts.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "Third Prize",
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
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      extendBody: true,
    );
  }

  void checkRegistration(String tournamentId, String registrationId) {
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    bool isRegistered = false;
    if (registrationId != "null") {
      isRegistered = true;
    }

    if (isRegistered) {
      return showCustomToast("Already Registered");
    } else {
      provider.soloRegistration(tournamentId, "Solo").then(
        (value) {
          if (value) {
            return showCustomToast("Registered Successfully!");
          }
        },
      );
    }
  }
}
