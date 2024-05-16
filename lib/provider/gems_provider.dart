//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/gems_model.dart';
import 'package:playverse/repository/gems_repo.dart';

class GemsProvider extends ChangeNotifier {
  final repo = GemsRepo();
  List<Gems> userGems = [];
  bool isLoading = false;

  Future<dynamic> getuserGems(int offset, String type) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getUserGems(offset, type);
      if (responseData['status_code'] == 200) {
        List<Gems> tempList =
            List<Gems>.from(responseData["data"]!.map((x) => Gems.fromJson(x)));
        offset == 1 ? userGems = tempList : userGems += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Gems Error Log');
      }
    } catch (e) {
      log("$e", name: "Gems List Error");
    }
  }
}
