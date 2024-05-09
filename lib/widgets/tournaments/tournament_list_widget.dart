//Thrid Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<TournamentsProvider, List<Tournaments>?>(
            selector: (p0, p1) => p1.tournamentList,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, paginationTournaments),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                                tournamentID: value?[index].tournamentId ??
                                    "TournamentID",
                              )),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.pink,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: value?[index].logo ?? "",
                                fit: BoxFit.cover,
                                height: 400,
                                width: 1000,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    color: Colors.black45,
                                  ),
                                  height: 20,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value?[index].title ??
                                            "Tournament Title",
                                        style: poppinsFonts.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
  }
}
