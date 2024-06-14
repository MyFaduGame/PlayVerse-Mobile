//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/games_model.dart';
import 'package:playverse/provider/games_provider.dart';
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
  late GamesListProvider gameProvider;
  Games? gameData;
  List<TournamentDetail>? tournamentList;
  bool isLoading = true;
  bool gameLoading = true;

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
    provider.dispose();
    gameProvider.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<TournamentsProvider>(context, listen: false);
    gameProvider = Provider.of<GamesListProvider>(context, listen: false);
    gameProvider.getSpecificGame(widget.gameUUID).then((value) {
      setState(() {
        gameLoading = true;
      });
    });
    paginationTournaments();
  }

  @override
  Widget build(BuildContext context) {
    gameData = context.select((GamesListProvider value) => value.gameData);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.25;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          gameData?.name ?? "GameName",
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
          IconButton(
            onPressed: () => {},
            icon: gameData?.added ?? true
                ? const Icon(
                    FontAwesomeIcons.heart,
                    size: 20,
                  )
                : const Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 20,
                  ),
          ),
        ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: gameData?.thumbnail ?? "",
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight - 400,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              paginationTournaments();
                            },
                            child: Selector<TournamentsProvider,
                                List<TournamentDetail>?>(
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
                                            Utils.scrollNotifier(notification,
                                                paginationTournaments),
                                        child: ListView.builder(
                                          clipBehavior: Clip.none,
                                          itemCount: value?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        TournamentDetailScreen(
                                                          tournamentDetail: value?[
                                                                  index] ??
                                                              TournamentDetail(),
                                                        )),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        imageUrl: value?[index]
                                                                .thumbnail ??
                                                            "",
                                                        fit: BoxFit.cover,
                                                        height: 100,
                                                        width: itemWidth - 50,
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: itemWidth - 10,
                                                      height: 100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                            "Ends In ${(value?[index].registrationClose ?? DateTime.now()).difference(DateTime.now()).inDays.toString()} Days",
                                                            style: poppinsFonts
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Text(
                                                            value?[index]
                                                                    .title ??
                                                                "Tournament",
                                                            style: poppinsFonts
                                                                .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              55),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 2),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              55),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        value?[index].logo ??
                                                                            "",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 25,
                                                                    width: 25,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            const CircularProgressIndicator(),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "Win Prize",
                                                                    style: poppinsFonts
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade100,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <Widget>[
                                                                      Image
                                                                          .asset(
                                                                        TournamentWidgetImages
                                                                            .winTrophyImage,
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                        value?[index].prizePool?.the1St.toString() ??
                                                                            "",
                                                                        style: poppinsFonts
                                                                            .copyWith(
                                                                          color:
                                                                              Colors.white38,
                                                                          fontSize:
                                                                              10,
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
                                                                      color: Colors
                                                                          .grey
                                                                          .shade100,
                                                                      fontSize:
                                                                          10,
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
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        value?[index].prizePool?.the1St.toString() ??
                                                                            "",
                                                                        style: poppinsFonts
                                                                            .copyWith(
                                                                          color:
                                                                              Colors.white38,
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
