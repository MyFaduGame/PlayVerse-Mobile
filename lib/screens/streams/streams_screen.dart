//Third Party Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/video_model.dart';
import 'package:playverse/screens/streams/stream_watch_screen.dart';

class StreamsScreen extends StatefulWidget {
  const StreamsScreen({super.key});

  @override
  State<StreamsScreen> createState() => _StreamsScreenState();
}

class _StreamsScreenState extends State<StreamsScreen> {
  bool fullscreen = false;

  final List<VideoData> youtubeLinks = [
    VideoData(
        thumbnail:
            "https://image.mux.com/7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw/thumbnail.png",
        id: "7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw"),
    VideoData(
        thumbnail:
            "https://image.mux.com/7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw/thumbnail.png",
        id: "7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw"),
    VideoData(
        thumbnail:
            "https://image.mux.com/7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw/thumbnail.png",
        id: "7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.none,
      itemCount: youtubeLinks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => StreamWatch(
                      url: index,
                    )),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: youtubeLinks[index].thumbnail ?? "",
                  fit: BoxFit.cover,
                  // height: 125,
                  // width: 125,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
