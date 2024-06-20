//Thrid Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/themes/app_images.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/screens/tournaments/tournament_detail_screen.dart';
import 'package:playverse/themes/app_font.dart';

class TournamentListWidget extends StatefulWidget {
  final String type;
  const TournamentListWidget({super.key, required this.type});

  @override
  State<TournamentListWidget> createState() => _TournamentListWidgetState();
}

class _TournamentListWidgetState extends State<TournamentListWidget> {
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
    await provider.getTournaments(offsetUpcoming, widget.type).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // provider.tournamentList.clear();
    // provider.dispose();
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
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<TournamentsProvider, List<TournamentDetail>?>(
            selector: (p0, p1) => p1.tournamentList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationTournaments),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: value?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: value?[index].thumbnail ?? "",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: itemWidth - 100,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: itemWidth - 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(55),
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(55),
                                        child: CachedNetworkImage(
                                          imageUrl: value?[index].logo ?? "",
                                          fit: BoxFit.cover,
                                          height: 40,
                                          width: 40,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            "${(value?[index].tournamentDate ?? DateTime.now()).difference(DateTime.now()).inDays.toString()} Days Remaning"),
                                        SizedBox(
                                          width: itemWidth - 250,
                                          child: Text(
                                            value?[index].title ?? "Tournament",
                                            style: poppinsFonts.copyWith(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Win Prize",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.grey.shade100,
                                            fontSize: 10,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                  ],
                                ),
                              )
                            ],
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
