//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playverse/models/video_model.dart';

//Local Imports
import 'package:playverse/repository/video_repo.dart';

class VideoProvider extends ChangeNotifier {
  final repo = VideoRepo();
  List<Streams> videoData = [];
  bool isLoading = false;

  Future<dynamic> getStreams(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getStreams(offset);
      if (responseData['status_code'] == 200) {
        List<Streams> tempList = List<Streams>.from(
            responseData["data"]!.map((x) => Streams.fromJson(x)));
          offset==1 ? videoData = tempList: videoData += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Logging for Get Streams');
      }
    } catch (e) {
      log("$e", name: "Error in Geting Streams");
    }
  }
}
