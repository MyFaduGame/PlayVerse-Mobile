//Third Party Imports
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/screens/streams/stream_watch_screen.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/models/video_model.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/provider/video_provider.dart';

class StreamsWidget extends StatefulWidget {
  const StreamsWidget({super.key});

  @override
  State<StreamsWidget> createState() => _StreamsWidgetState();
}

class _StreamsWidgetState extends State<StreamsWidget> {
  late VideoProvider provider;
  bool loading = true, loader = false, paginate = true;
  int limit = 12;
  int offset = 1;
  int page = 1;

  Future<void> pagination() async {
    if (!paginate) return;
    setState(() {
      loader = true;
    });
    await provider.getStreams(offset).then((value) {
      if (value < 12) paginate = false;
      loader = false;
      offset += limit;
      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<VideoProvider>(context, listen: false);
    pagination();
  }

  @override
  void dispose() {
    super.dispose();
    provider.videoData.clear();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Selector<VideoProvider, List<Streams>>(
            selector: (p0, p1) => p1.videoData,
            builder: (context, value, child) {
              return NotificationListener(
                onNotification: (notification) =>
                    Utils.scrollNotifier(notification, pagination),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => StreamWatch(
                                url: value[index].streamLink ?? "",
                              )),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: value[index].thumbnail ?? "",
                                fit: BoxFit.fill,
                                height: 150,
                                width: 300,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            SizedBox(
                              width: 290,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(55),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: CachedNetworkImage(
                                        imageUrl: value[index].logo ?? "",
                                        fit: BoxFit.cover,
                                        height: 35,
                                        width: 35,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Text(
                                        value[index].title ?? "",
                                        style: poppinsFonts.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        value[index].gameName ?? "",
                                        style: openSansFonts.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          "${Random().nextInt(10) + 10}k Views",
                                          style: poppinsFonts.copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat('dd/MM/yy').format(
                                            value[index].tournamentDate ??
                                                DateTime.now()),
                                        style: openSansFonts.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
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
}
