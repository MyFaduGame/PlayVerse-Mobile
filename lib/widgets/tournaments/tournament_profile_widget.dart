//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/screens/tournaments/tournament_detail_screen.dart';
import 'package:playverse/themes/app_font.dart';

class TournamentProfileWidget extends StatefulWidget {
  const TournamentProfileWidget({super.key});

  @override
  State<TournamentProfileWidget> createState() =>
      TournamentProfileWidgetState();
}

class TournamentProfileWidgetState extends State<TournamentProfileWidget> {
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
    await provider.getUserTournaments(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.userTournamentList.clear();
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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.25;
    final double itemWidth = size.width / 2;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              paginationTournaments();
            },
            child: Selector<TournamentsProvider, List<TournamentDetail>?>(
              selector: (p0, p1) => p1.userTournamentList,
              builder: (context, value, child) {
                return NotificationListener(
                  onNotification: (notification) =>
                      Utils.scrollNotifier(notification, paginationTournaments),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.none,
                    itemCount: value?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => TournamentDetailScreen(
                                    tournamentID:
                                        value?[index].tournamentId ?? "",
                                  )),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: value?[index].thumbnail ?? "",
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: itemWidth - 20,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              SizedBox(
                                width: itemWidth - 10,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Ends In ${(value?[index].registrationClose ?? DateTime.now()).difference(DateTime.now()).inDays.toString()} Days",
                                      style: poppinsFonts.copyWith(
                                          color: Colors.grey, fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      value?[index].title ?? "Tournament",
                                      style: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(55),
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(55),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  value?[index].logo ?? "",
                                              fit: BoxFit.cover,
                                              height: 25,
                                              width: 25,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Win Prize",
                                              style: poppinsFonts.copyWith(
                                                color: Colors.grey.shade100,
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
                                                  style: poppinsFonts.copyWith(
                                                    color: Colors.white38,
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
                                              style: poppinsFonts.copyWith(
                                                color: Colors.grey.shade100,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Icon(
                                                  FontAwesomeIcons.userGroup,
                                                  color: Colors.white,
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
                                                  style: poppinsFonts.copyWith(
                                                    color: Colors.white38,
                                                    fontSize: 10,
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
          );
  }
}
