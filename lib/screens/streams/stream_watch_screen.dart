//Third Party Imports
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class StreamApp extends StatefulWidget {
  const StreamApp({super.key});

  @override
  State<StreamApp> createState() => _StreamAppState();
}

class _StreamAppState extends State<StreamApp> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            fullscreen ? EdgeInsets.zero : const EdgeInsets.only(top: 32.0),
        child: YoYoPlayer(
          aspectRatio: 16 / 9,
          url:
              'https://stream.mux.com/HS1gaJEohKn00GO00JhL8b5uvSj7JRVLrwodxQ9IhcUCI.m3u8',
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
              Icons.add_circle_outline_outlined,
              size: 40.0,
              color: Colors.white,
            ),
            pauseIcon: Icon(
              Icons.remove_circle_outline_outlined,
              size: 40.0,
              color: Colors.white,
            ),
            videoQualityPadding: EdgeInsets.all(5.0),
            // showLiveDirectButton: true,
            // enableSystemOrientationsOverride: false,
          ),
          videoLoadingStyle: const VideoLoadingStyle(
            loading: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('image/yoyo_logo.png'),
                    fit: BoxFit.fitHeight,
                    height: 50,
                  ),
                  SizedBox(height: 16.0),
                  Text("Loading video..."),
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
