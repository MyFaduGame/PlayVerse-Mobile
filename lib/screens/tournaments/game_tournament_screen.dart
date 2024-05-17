//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/screens/tournaments/tournament_detail_screen.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';

class GamesTournamentScreen extends StatefulWidget {
  final String gameUUID;
  const GamesTournamentScreen({super.key, required this.gameUUID});

  @override
  State<GamesTournamentScreen> createState() => GamesTournamentScreenState();
}

class GamesTournamentScreenState extends State<GamesTournamentScreen> {
  late TournamentsProvider provider;
  List<TournamentDetail>? tournamentList;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationTournaments() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider
        .getGamesTournaments(offsetUpcoming, widget.gameUUID)
        .then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.gamesTournamentList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    paginationTournaments();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120), child: BackAppBar()),
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
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      paginationTournaments();
                    },
                    child:
                        Selector<TournamentsProvider, List<TournamentDetail>?>(
                      selector: (p0, p1) => p1.gamesTournamentList,
                      builder: (context, value, child) {
                        return value?.isEmpty ?? true
                            ? Center(
                                child: Container(
                                  // width: screenWidth / 2,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Colors.black54,
                                  ),
                                  child: Text(
                                    "No Tournaments of this Game",
                                    style: openSansFonts.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            : NotificationListener(
                                onNotification: (notification) =>
                                    Utils.scrollNotifier(
                                        notification, paginationTournaments),
                                child: GridView.builder(
                                  clipBehavior: Clip.none,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio:
                                        screenWidth / screenHeight * 3,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 15.0,
                                  ),
                                  itemCount: value?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              TournamentDetailScreen(
                                                tournamentDetail:
                                                    value?[index] ??
                                                        TournamentDetail(),
                                              )),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: CachedNetworkImage(
                                                      imageUrl: value?[index]
                                                              .thumbnail ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      height: 100,
                                                      width: double.infinity,
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        DateFormat(
                                                                'dd-MMMM-yyyy')
                                                            .format(value?[
                                                                        index]
                                                                    .tournamentDate ??
                                                                DateTime.now()),
                                                        style: poppinsFonts
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        value?[index].title ??
                                                            "",
                                                        style: poppinsFonts
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Register Now Limited Slots Available",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: poppinsFonts
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: Colors.white70,
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "Win Prize",
                                                            style: poppinsFonts
                                                                .copyWith(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Image.asset(
                                                                TournamentWidgetImages
                                                                    .winTrophyImage,
                                                                height: 15,
                                                                width: 15,
                                                              ),
                                                              Text(
                                                                value?[index]
                                                                        .prizePool
                                                                        ?.the1St
                                                                        .toString() ??
                                                                    "",
                                                                style:
                                                                    poppinsFonts
                                                                        .copyWith(
                                                                  color: Colors
                                                                      .white38,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "Player Slots",
                                                            style: poppinsFonts
                                                                .copyWith(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              const Icon(
                                                                FontAwesomeIcons
                                                                    .userGroup,
                                                                color: Colors
                                                                    .white,
                                                                size: 10,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                value?[index]
                                                                        .prizePool
                                                                        ?.the1St
                                                                        .toString() ??
                                                                    "",
                                                                style:
                                                                    poppinsFonts
                                                                        .copyWith(
                                                                  color: Colors
                                                                      .white38,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: TournamentWidgetColors
                                                              .tournamentDetailCircleColor,
                                                        ),
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .arrowRight,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Positioned(
                                                top: 90,
                                                left: 10,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              value?[index]
                                                                      .logo ??
                                                                  "",
                                                          fit: BoxFit.cover,
                                                          height: 30,
                                                          width: 30,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                      Text(
                                                        value?[index]
                                                                .gameName ??
                                                            "",
                                                        style: poppinsFonts
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
