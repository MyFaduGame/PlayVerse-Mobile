//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:playverse/screens/tournaments/tournament_detail_screen.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
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
    await provider.getTournaments(offsetUpcoming, 'Solo').then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.tournamentList.clear();
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
    // double screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              paginationTournaments();
            },
            child: Selector<TournamentsProvider, List<TournamentDetail>?>(
                selector: (p0, p1) => p1.tournamentList,
                builder: (context, value, child) {
                  return NotificationListener(
                    onNotification: (notification) => Utils.scrollNotifier(
                        notification, paginationTournaments),
                    child: ListView.builder(
                      itemCount: value?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: value?[index].logo ?? "",
                                    fit: BoxFit.fill,
                                    height: 60,
                                    width: 60,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth / 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value?[index].title ??
                                            "Tournament Title",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: openSansFonts.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd-MMMM-yyyy').format(
                                          value?[index].tournamentDate ??
                                              DateTime.now(),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: openSansFonts.copyWith(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Colors.pink[200],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TournamentDetailScreen(
                                            tournamentDetail: value?[index] ??
                                                TournamentDetail(),
                                          ),
                                        ),
                                      );
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                      FontAwesomeIcons.arrowRightLong,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          );
  }
}
