//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Local Imports
import 'package:playverse/models/video_model.dart';
import 'package:playverse/screens/streams/stream_watch_screen.dart';
import 'package:playverse/utils/helper_utils.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/provider/video_provider.dart';

class StreamsScreen extends StatefulWidget {
  const StreamsScreen({super.key});

  @override
  State<StreamsScreen> createState() => _StreamsScreenState();
}

class _StreamsScreenState extends State<StreamsScreen> {
  bool fullscreen = false;
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: value[index].thumbnail ?? "",
                                fit: BoxFit.fill,
                                height: 150,
                                width: 250,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Text(
                            value[index].title ?? "",
                            style: openSansFonts.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
