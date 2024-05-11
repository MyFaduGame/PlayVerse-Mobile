//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/games_model.dart';
import 'package:playverse/provider/games_provider.dart';

class GamesIconWidget extends StatefulWidget {
  const GamesIconWidget({super.key});

  @override
  State<GamesIconWidget> createState() => _GamesIconWidgetState();
}

class _GamesIconWidgetState extends State<GamesIconWidget> {
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
    await provider.userGames(offsetUpcoming).then((value) {
      if (value < 10) paginateUpcoming = false;
      loader = false;
      offsetUpcoming += 10;
      loading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    provider.userGameList.clear();
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
    return Selector<GamesListProvider, List<Games>?>(
      selector: (p0, p1) => p1.gameList,
      builder: (context, value, child) {
        return NotificationListener(
          onNotification: (notification) =>
              Utils.scrollNotifier(notification, paginationGames),
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: value?.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: value?[index].logo ?? "",
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
