//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Local Imports
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/provider/tournaments_provider.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';
import 'package:playverse/themes/app_color_theme.dart';

class TournamentDetailScreen extends StatefulWidget {
  final TournamentDetail tournamentDetail;
  const TournamentDetailScreen({super.key, required this.tournamentDetail});

  @override
  State<TournamentDetailScreen> createState() => TournamentDetailScreenState();
}

class TournamentDetailScreenState extends State<TournamentDetailScreen> {
  late TournamentsProvider provider;
  TournamentDetail? tournamentDetail;
  bool isLoading = true;
  PrizePool? prizePool;

  @override
  void initState() {
    super.initState();
    // provider = Provider.of<TournamentsProvider>(context, listen: false);
    // provider.getTournamentsDetail(widget.tournamentID).then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    prizePool = widget.tournamentDetail.prizePool ?? PrizePool();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // tournamentDetail =
    //     context.select((TournamentsProvider value) => value.tournamentDetail);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: BackAppBar(),
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 120, 10, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            // CachedNetworkImage(
                            //   imageUrl: widget.tournamentDetail.thumbnail ?? "",
                            //   fit: BoxFit.cover,
                            //   height: 200,
                            //   width: double.infinity,
                            //   placeholder: (context, url) =>
                            //       const CircularProgressIndicator(),
                            //   errorWidget: (context, url, error) =>
                            //       const Icon(Icons.error),
                            // ),
                            Positioned(
                              top: 200,
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          widget.tournamentDetail.logo ?? "",
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: double.infinity,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    widget.tournamentDetail.maxPlayers
                                        .toString(),
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Total Players",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    widget.tournamentDetail.maxPlayers
                                        .toString(),
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Total Players",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: TournamentDetialScreenColors
                                    .tournamentContainerColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    widget.tournamentDetail.maxPlayers
                                        .toString(),
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Total Players",
                                    style: poppinsFonts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: TournamentDetialScreenColors.dividerColor,
                          thickness: 2,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "\$${widget.tournamentDetail.prizePool?.the1St}",
                              style: poppinsFonts.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: TournamentDetialScreenColors.dividerColor,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
