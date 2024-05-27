//Third Party Imports
import 'dart:developer';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/video_model.dart';
import 'package:playverse/themes/app_font.dart';
import 'package:playverse/widgets/common/back_app_bar_widget.dart';

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

class StreamWatch extends StatefulWidget {
  final String url;
  const StreamWatch({super.key, required this.url});

  @override
  State<StreamWatch> createState() => _StreamWatchState();
}

class _StreamWatchState extends State<StreamWatch> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: fullscreen
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: BackAppBar(),
            ),
      body: Padding(
        padding:
            fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
        child: YoYoPlayer(
          aspectRatio: 16 / 9,
          url: widget.url,
          // url:
          //     'https://stream.mux.com/7dPImcsEC28yyAgrpYJCA01bjRFBLRzGED019oKkqv1dw.m3u8',
          // 'https://dsqqu7oxq6o1v.cloudfront.net/preview-9650dW8x3YLoZ8.webm',
          // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          //  "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
          //"https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
          allowCacheFile: true,
          onCacheFileCompleted: (files) {
            log('Cached file length ::: ${files?.length}');

            if (files != null && files.isNotEmpty) {
              for (var file in files) {
                log('File path ::: ${file.path}');
              }
            }
          },
          onCacheFileFailed: (error) {
            log('Cache file error ::: $error');
          },
          videoStyle: const VideoStyle(
            qualityStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            forwardAndBackwardBtSize: 30.0,
            playButtonIconSize: 40.0,
            playIcon: Icon(
              FontAwesomeIcons.play,
              size: 40.0,
              color: Colors.white,
            ),
            pauseIcon: Icon(
              FontAwesomeIcons.pause,
              size: 40.0,
              color: Colors.white,
            ),
            videoQualityPadding: EdgeInsets.all(5.0),
            // showLiveDirectButton: true,
            // enableSystemOrientationsOverride: false,
          ),
          videoLoadingStyle: VideoLoadingStyle(
            loading: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image(
                  //   image: AssetImage('image/yoyo_logo.png'),
                  //   fit: BoxFit.fitHeight,
                  //   height: 50,
                  // ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Loading video...",
                    style: poppinsFonts.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          onFullScreen: (value) {
            setState(() {
              if (fullscreen != value) {
                fullscreen = value;
              }
            });
          },
        ),
      ),
    );
  }
}
