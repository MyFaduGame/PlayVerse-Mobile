//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playverse/models/video_model.dart';

//Local Imports
import 'package:playverse/repository/video_repo.dart';

class VideoProvider extends ChangeNotifier {
  final repo = VideoRepo();
  List<VideoData>? videoData;
  bool isLoading = false;

  Future<dynamic> getStreams() async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getStreams();
      if (responseData['status_code'] == 200) {
        videoData = List<VideoData>.from(
            responseData["data"]!.map((x) => VideoData.fromJson(x)));
        isLoading = false;
        notifyListeners();
        return videoData;
      } else {
        log(responseData.toString(), name: 'Logging for Get Streams');
      }
    } catch (e) {
      log("$e", name: "Error in Geting Streams");
    }
  }
}
