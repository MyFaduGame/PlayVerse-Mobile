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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
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
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: itemWidth / itemHeight,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemCount: value?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => TournamentDetailScreen(
                                tournamentID: value?[index].tournamentId ?? "",
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
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text(
                                      value?[index].title ?? "Tournament",
                                      style: poppinsFonts.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                                          TournamentWidgetImages.winTrophyImage,
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
                            )
                          ],
                        ),
                      ),
                    );
                    // return GestureDetector(
                    //
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(
                    //         color: Colors.grey.shade500,
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Stack(
                    //         children: [
                    //           Column(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     DateFormat('dd-MMMM-yyyy').format(
                    //                         value?[index].tournamentDate ??
                    //                             DateTime.now()),
                    //                     style: poppinsFonts.copyWith(
                    //                       color: Colors.white,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     value?[index].title ?? "",
                    //                     style: poppinsFonts.copyWith(
                    //                       color: Colors.white,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 20,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     getRandomDescriptionForTournament(),
                    //                     maxLines: 2,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: poppinsFonts.copyWith(
                    //                       color: Colors.white,
                    //                       fontSize: 15,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               const Divider(
                    //                 color: Colors.white70,
                    //                 height: 2,
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceEvenly,
                    //                 children: <Widget>[
                    //                   Container(
                    //                     width: 40,
                    //                     height: 40,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(50),
                    //                       color: TournamentWidgetColors
                    //                           .tournamentDetailCircleColor,
                    //                     ),
                    //                     child: const Icon(
                    //                       FontAwesomeIcons.arrowRight,
                    //                       color: Colors.white,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //           Positioned(
                    //             top: 70,
                    //             left: 10,
                    //             child: Container(
                    //               width: 100,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.black,
                    //                 borderRadius: BorderRadius.circular(15),
                    //                 border: Border.all(
                    //                   color: Colors.grey.shade500,
                    //                 ),
                    //               ),
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceEvenly,
                    //                 children: <Widget>[
                    //                   ClipRRect(
                    //                     borderRadius: BorderRadius.circular(15),
                    //                     child: CachedNetworkImage(
                    //                       imageUrl: value?[index].logo ?? "",
                    //                       fit: BoxFit.cover,
                    //                       height: 30,
                    //                       width: 30,
                    //                       placeholder: (context, url) =>
                    //                           const CircularProgressIndicator(),
                    //                       errorWidget: (context, url, error) =>
                    //                           const Icon(Icons.error),
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     value?[index].gameName ?? "",
                    //                     style: poppinsFonts.copyWith(
                    //                       color: Colors.white,
                    //                       fontSize: 10,
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              );
            },
          );
  }
}
