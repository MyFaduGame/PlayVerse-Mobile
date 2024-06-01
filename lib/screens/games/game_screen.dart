//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/shimmer/neopop_shimmer.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/games_model.dart';
import 'package:playverse/provider/games_provider.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  late GamesListProvider provider;
  List<Games>? gameModel;
  bool isLoading = true;

  bool loading = true, loader = false, paginateUpcoming = true;
  int offsetUpcoming = 1;

  Future<void> paginationGames() async {
    if (!paginateUpcoming) return;
    setState(() {
      loader = true;
      isLoading = false;
    });
    await provider.getGamesList(offsetUpcoming).then((value) {
      if (value < 12) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 12;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.gameList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<GamesListProvider>(context, listen: false);
    paginationGames();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Selector<GamesListProvider, List<Games>?>(
            selector: (p0, p1) => p1.gameList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationGames),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 9 / 16,
                  ),
                  clipBehavior: Clip.none,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: value?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        addGameInfo(
                          context,
                          value?[index] ?? Games(),
                        ),
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5,
                                      color: value?[index].added ?? true
                                          ? GeneralColors.neopopButtonMainColor
                                          : Colors.transparent)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: value?[index].logo ?? "",
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Container(
                              color: value?[index].added ?? false
                                  ? GeneralColors.neopopShadowColor
                                  : Colors.transparent,
                              width: 150,
                              height: 20,
                              child: FittedBox(
                                child: Text(
                                  "${value?[index].name}",
                                  style: openSansFonts.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }

  Future<void> popUpMenu(
      BuildContext context, bool added, Games gameData) async {
    double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        builder: (context) {
          return added
              ? AlertDialog(
                  clipBehavior: Clip.none,
                  actions: [
                    Container(
                      width: screenWidth,
                      color: Colors.black,
                      height: 300,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Want to Remove?",
                                  style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  // width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Colors.pink[200],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      deleteGames(
                                          context, gameData.gameId ?? "GameID");
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                      FontAwesomeIcons.minus,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: [
                                Text(
                                  "Want to Update Name?",
                                  style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Colors.pink[200],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      addGame(context,
                                          gameData.gameId ?? "GameID", true);
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                      FontAwesomeIcons.pen,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                )
              : AlertDialog(
                  actions: [
                    Container(
                      width: screenWidth,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Text(
                            "Want to Add Game?",
                            style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 40,
                            // height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.pink[200],
                            ),
                            child: IconButton(
                              onPressed: () {
                                addGame(context, gameData.gameId ?? "GameID");
                              },
                              color: Colors.white,
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        });
  }

  Future<void> addGameInfo(BuildContext context, Games gameData) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Here is the Game Inforamtion'),
          content: SizedBox(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Text(
                  gameData.name ?? "Game Name",
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: gameData.thumbnail ?? "",
                    fit: BoxFit.cover,
                    height: 150,
                    width: 200,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  gameData.gameType ?? "Game Type",
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  gameData.genre ?? "Game Type",
                  style: poppinsFonts.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                gameData.added == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth / 4,
                            child: NeoPopButton(
                              color: GeneralColors.neopopButtonMainColor,
                              bottomShadowColor:
                                  GeneralColors.neopopShadowColor,
                              onTapUp: () => {
                                HapticFeedback.vibrate(),
                                addGame(context, gameData.gameId ?? "Game ID",
                                    true),
                              },
                              child: const NeoPopShimmer(
                                shimmerColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Text(
                                    "Edit Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth / 4,
                            child: NeoPopButton(
                              color: GeneralColors.neopopButtonMainColor,
                              bottomShadowColor:
                                  GeneralColors.neopopShadowColor,
                              onTapUp: () => {
                                HapticFeedback.vibrate(),
                                deleteGames(
                                    context, gameData.gameId ?? "Game ID"),
                              },
                              child: const NeoPopShimmer(
                                shimmerColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Text(
                                    "Remove From Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: screenWidth / 1.5,
                        child: NeoPopButton(
                          color: GeneralColors.neopopButtonMainColor,
                          bottomShadowColor: GeneralColors.neopopShadowColor,
                          onTapUp: () => {
                            HapticFeedback.vibrate(),
                            addGame(context, gameData.gameId ?? "Game ID"),
                          },
                          child: const NeoPopShimmer(
                            shimmerColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Text(
                                "Add to Profile",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addGame(BuildContext context, String gamesId,
      [bool? update]) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController textEditingController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.deepPurpleAccent[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.pink,
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
                style: gamePausedFonts.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (update == true) {
                  provider
                      .addGames(gamesId, textEditingController.text, update)
                      .then(
                    (value) {
                      loading = true;
                      loader = false;
                      paginateUpcoming = true;
                      offsetUpcoming = 1;
                      paginationGames();
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  provider.addGames(gamesId, textEditingController.text).then(
                    (value) {
                      loading = true;
                      loader = false;
                      paginateUpcoming = true;
                      offsetUpcoming = 1;
                      paginationGames();
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              child: Text(
                'Add it!',
                style: gamePausedFonts.copyWith(
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

  Future<void> deleteGames(BuildContext context, String gamesId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0XFF252849),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.pink,
          title: const Text('Really Want to Remove?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Decline!',
                style: poppinsFonts.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                provider.deleteGames(gamesId).then(
                  (value) {
                    loading = true;
                    loader = false;
                    paginateUpcoming = true;
                    offsetUpcoming = 1;
                    paginationGames();
                    Navigator.of(context).pop();
                  },
                );
              },
              child: Text(
                'Remove!',
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
