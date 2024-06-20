//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/widgets/common/header_widget.dart';
import 'package:playverse/models/games_model.dart';
import 'package:playverse/provider/games_provider.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/screens/tournaments/tournament_detail_screen.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';

class GamesTournamentScreen extends StatefulWidget {
  final Games gameData;
  final String gameUUID;
  const GamesTournamentScreen(
      {super.key, required this.gameUUID, required this.gameData});

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
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.25;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: const Color(0xFF000019),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
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
            onPressed: () => {
              widget.gameData.added == true
                  ? deleteGames(
                      context,
                      widget.gameData.gameId ?? "Game Id",
                    )
                  : addGame(context, widget.gameData.gameId ?? "GameId"),
            },
            icon: const Icon(
              FontAwesomeIcons.solidHeart,
              size: 20,
            ),
            color: widget.gameData.added ?? false ? Colors.red : Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: gameData?.thumbnail ?? "",
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                // placeholder: (context, url) =>
                //     const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            NoramlHeaderWidget(
                title: "Here Some",
                subTitle: "${widget.gameData.name} Tournaments"),
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
                                      Utils.scrollNotifier(
                                          notification, paginationTournaments),
                                  child: ListView.builder(
                                    clipBehavior: Clip.none,
                                    itemCount: value?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  TournamentDetailScreen(
                                                    tournamentID: value?[index]
                                                            .tournamentId ??
                                                        "",
                                                  )),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      value?[index].thumbnail ??
                                                          "",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: itemWidth - 50,
                                                  // placeholder: (context, url) =>
                                                  //     const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              SizedBox(
                                                width: itemWidth - 10,
                                                height: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "Ends In ${(value?[index].registrationClose ?? DateTime.now()).difference(DateTime.now()).inDays.toString()} Days",
                                                      style:
                                                          poppinsFonts.copyWith(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      value?[index].title ??
                                                          "Tournament",
                                                      style:
                                                          poppinsFonts.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        55),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: value?[
                                                                          index]
                                                                      .logo ??
                                                                  "",
                                                              fit: BoxFit.cover,
                                                              height: 25,
                                                              width: 25,
                                                              // placeholder: (context,
                                                              //         url) =>
                                                              //     const CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "Win Prize",
                                                              style:
                                                                  poppinsFonts
                                                                      .copyWith(
                                                                color: Colors
                                                                    .grey
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
                                                                  style: poppinsFonts
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .white38,
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
                                                              style:
                                                                  poppinsFonts
                                                                      .copyWith(
                                                                color: Colors
                                                                    .grey
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
                                                                  style: poppinsFonts
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .white38,
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
    );
  }

  Future<void> addGame(BuildContext context, String gamesId,
      [bool? update]) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController textEditingController = TextEditingController();
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('What\'s your in Game Name?'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter your in Game Name Here!',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Decline!',
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (update == true) {
                  gameProvider
                      .addGames(gamesId, textEditingController.text, update)
                      .then(
                    (value) {
                      loading = true;
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  gameProvider
                      .addGames(gamesId, textEditingController.text)
                      .then(
                    (value) {
                      gameProvider.gameList.clear();
                      loading = true;
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              child: Text(
                'Add it!',
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteGames(BuildContext context, String gameId) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController textEditingController = TextEditingController();
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Update your in GameName?'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter your in Game Name Here!',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                gameProvider.deleteGames(gameId).then((value) => {
                      gameProvider.gameList.clear(),
                      loading = true,
                      Navigator.of(context).pop(),
                    });
              },
              child: Text(
                'Remove!',
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                gameProvider
                    .addGames(gameId, textEditingController.text, true)
                    .then(
                  (value) {
                    gameProvider.gameList.clear();
                    loading = true;
                    Navigator.of(context).pop();
                  },
                );
              },
              child: Text(
                'Update!',
                style: poppinsFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
