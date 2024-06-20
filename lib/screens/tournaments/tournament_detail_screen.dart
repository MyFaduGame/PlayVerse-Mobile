//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/widgets/games/games_icon_widget.dart';
import 'package:playverse/widgets/tournaments/tournament_list_widget.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/loader_dialouge.dart';
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/themes/app_color_theme.dart';

class TournamentDetailScreen extends StatefulWidget {
  // final TournamentDetail tournamentDetail;
  final String tournamentID;
  const TournamentDetailScreen({super.key, required this.tournamentID});

  @override
  State<TournamentDetailScreen> createState() => TournamentDetailScreenState();
}

class TournamentDetailScreenState extends State<TournamentDetailScreen> {
  final AdvancedDrawerController controller = AdvancedDrawerController();
  late TournamentsProvider provider;
  TournamentDetail? tournamentDetail;
  bool isLoading = true;
  PrizePool? prizePool;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    provider.getTournamentsDetail(widget.tournamentID).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tournamentDetail =
        context.select((TournamentsProvider value) => value.tournamentDetail);
    prizePool = tournamentDetail?.prizePool ?? PrizePool();
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF000019),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "Tournaments",
          style: poppinsFonts.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 20,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: tournamentDetail?.thumbnail ?? "",
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: CachedNetworkImage(
                                imageUrl: tournamentDetail?.logo ?? "",
                                fit: BoxFit.fill,
                                height: 100,
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
                                FittedBox(
                                  child: Text(
                                    tournamentDetail?.title ?? "Game Name",
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
                                          color: const Color(0xFF2F4F4F),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        tournamentDetail?.isRegistrationOpen ??
                                            "Open",
                                        style: poppinsFonts.copyWith(
                                          color: Colors.blue.shade100,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(55),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                tournamentDetail?.logo ?? "",
                                            fit: BoxFit.fill,
                                            height: 20,
                                            width: 20,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Text(
                                          tournamentDetail?.gameName
                                                  .toString() ??
                                              "",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Game Name",
                                      style: poppinsFonts.copyWith(
                                        color: const Color(0xFFBF99FF),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey,
                                height: 50,
                                width: 1,
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.userGear,
                                          size: 20,
                                          color: Color(0xFFBF99FF),
                                        ),
                                        Text(
                                          tournamentDetail?.playerLeft
                                                  .toString() ??
                                              "",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
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
                                color: Colors.grey,
                                height: 50,
                                width: 1,
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.userGear,
                                          size: 20,
                                          color: Color(0xFFBF99FF),
                                        ),
                                        Text(
                                          tournamentDetail?.maxPlayers
                                                  .toString() ??
                                              "",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
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
                                color: Colors.grey,
                                height: 50,
                                width: 1,
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.ticket,
                                          size: 20,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          tournamentDetail?.registrationFee ==
                                                  null
                                              ? "Free"
                                              : tournamentDetail
                                                      ?.registrationFee
                                                      .toString() ??
                                                  "",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Fees",
                                      style: poppinsFonts.copyWith(
                                        color: const Color(0xFFBF99FF),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey,
                                height: 50,
                                width: 1,
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gem,
                                          color: Colors.teal.shade400,
                                        ),
                                        Text(
                                          tournamentDetail?.prizePool?.the1St ??
                                              "0",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
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
                        ),
                        const SizedBox(height: 8),
                        Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1,
                        ),
                        const SizedBox(height: 16),
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
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1,
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
                                  "G ${tournamentDetail?.prizePool?.the1St}",
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
                                  "G ${tournamentDetail?.prizePool?.the2nd}",
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
                                  "G ${tournamentDetail?.prizePool?.the3rd}",
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
                    // NoramlHeaderWidget(
                    //     title: "More Tournaments of",
                    //     subTitle: tournamentDetail?.gameName ?? "GameName"),
                    // const SizedBox(
                    //   height: 280,
                    //   child: GamesTournamentScreen(gameUUID: tournamentDetail?, gameData: gameData)
                    // ),
                    const HeaderWidget(
                      title: "Trending",
                      subTitle: "Upcomming Matches",
                      index: 1,
                    ),
                    const SizedBox(
                      height: 280,
                      child: TournamentListWidget(
                        type: "Solo",
                      ),
                    ),
                    const SizedBox(height: 8),
                    const HeaderWidget(
                        title: "Search by", subTitle: "Games", index: 4),
                    const SizedBox(
                      height: 100,
                      child: GamesIconWidget(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
      extendBody: true,
      floatingActionButton: TextButton(
        onPressed: tournamentDetail?.registrationId == null
            ? () => {}
            : () => {showCustomToast("Tournament Already Registered")},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          width: screenWidth - 50,
          child: Center(
            child: Text(
              tournamentDetail?.registrationId == null
                  ? "Join Tournament"
                  : "Registered.",
              style: poppinsFonts.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
