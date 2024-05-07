//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/achievements_model.dart';
import 'package:playverse/repository/achievements_repo.dart';

class AchievementsProvider extends ChangeNotifier {
  
  final repo = AcheivementsRepo();
  List<Achievements> userAchievements = [];
  List<Achievements> allAchievements = [];
  bool isLoading = false;

  Future<dynamic> getUserAchievements(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.userAchievements(offset);
      if (responseData['status_code'] == 200) {
        List<Achievements> tempList = List<Achievements>.from(
            responseData["data"]!.map((x) => Achievements.fromJson(x)));
        offset==1 ? userAchievements = tempList: userAchievements += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Achievements Error Log');
      }
    } catch (e) {
      log("$e", name: "Achievement List Error");
    }
  }

  Future<dynamic> getAllAchievements(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.allAchievements(offset);
      if (responseData['status_code'] == 200) {
        List<Achievements> tempList = List<Achievements>.from(
            responseData["data"]!.map((x) => Achievements.fromJson(x)));
        offset==1 ? allAchievements = tempList: allAchievements += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Achievements Error Log');
      }
    } catch (e) {
      log("$e", name: "Achievement List Error");
    }
  }

}
