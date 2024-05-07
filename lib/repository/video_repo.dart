//Third Party Imports
import 'dart:developer';

//Local Imports
import 'package:playverse/models/video_model.dart';
import 'package:playverse/utils/video_client.dart';

class VideoRepository {
  final VideoClient _client;
  const VideoRepository({
    required VideoClient client,
  }) : _client = client;

  Future<List<Video>> getVideos() async {
    try {
      log(Video.sampleVideos.toString(), name: "strings");
      log("hello", name: "hello");
      final videos = Video.sampleVideos
          .map((videoJson) => Video.fromJson(videoJson))
          .toList();
      // final videos = await Future.delayed(
      //   const Duration(seconds: 1),
      //   () => Video.sampleVideos
      //       .map((videoJson) => Video.fromJson(videoJson))
      //       .toList(),
      // );
      log(videos.toString(), name: "new");
      final updatedVideos = <Video>[];
      for (var video in videos) {
        final muxAssetJson = await _client.getMuxAsset(video.muxId);
        log(muxAssetJson.toString(),name:"response");
        final muxAsset = MuxAsset.fromJson(muxAssetJson['data']);
        updatedVideos.add(video.copyWith(muxAsset: muxAsset));
      }
      log(updatedVideos.toString(), name: "Video Log");
      return updatedVideos;
    } catch (err) {
      throw Exception('Failed to load videos $err');
    }
  }
}
