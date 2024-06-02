//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_color_theme.dart';
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
  List<Tournaments>? tournamentList;
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<TournamentsProvider, List<TournamentDetail>?>(
            selector: (p0, p1) => p1.userTournamentList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationTournaments),
                child: ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  itemCount: value?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => TournamentDetailScreen(
                                  tournamentDetail:
                                      value?[index] ?? TournamentDetail(),
                                )),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: value?[index].thumbnail ?? "",
                                    fit: BoxFit.cover,
                                    height: 80,
                                    width: double.infinity,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        value?[index].title ?? "",
                                        style: poppinsFonts.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: TournamentWidgetColors
                                              .tournamentDetailCircleColor,
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.arrowRight,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
