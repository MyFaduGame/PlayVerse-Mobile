//Third Party Imports
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class StreamsScreen extends StatefulWidget {
  const StreamsScreen({super.key});

  @override
  State<StreamsScreen> createState() => _StreamsScreenState();
}

class _StreamsScreenState extends State<StreamsScreen> {
  final List<String> youtubeLinks = [
    'https://www.youtube.com/watch?v=YVkUvmDQ3HY&pp=ygUGZW1pbmVt',
    'https://www.youtube.com/watch?v=YVkUvmDQ3HY&pp=ygUGZW1pbmVt',
    'https://www.youtube.com/watch?v=YVkUvmDQ3HY&pp=ygUGZW1pbmVt',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: youtubeLinks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Video ${index + 1}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    YouTubePlayerScreen(url: youtubeLinks[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class YouTubePlayerScreen extends StatefulWidget {
  final String url;

  const YouTubePlayerScreen({super.key, required this.url});

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Player'),
      ),
      body: YoYoPlayer(
        aspectRatio: 16 / 9,
        url: widget.url,
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
    );
  }
}
