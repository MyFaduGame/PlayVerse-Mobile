//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/games_model.dart';
import 'package:playverse/repository/games_repo.dart';
import 'package:playverse/utils/toast_bar.dart';

class GamesListProvider extends ChangeNotifier {

  final repo = GamesRepo();
  List<Games> gameList = [];
  List<Games> userGameList = [];
  bool isLoading = false;

  Future<dynamic> getGamesList(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.gamesListApi(offset);
      if (responseData['status_code'] == 200) {
        List<Games> tempList = List<Games>.from(
            responseData["data"]!.map((x) => Games.fromJson(x)));
        offset == 1 ? gameList = tempList : gameList += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Game List Log');
      }
    } catch (e) {
      log("$e", name: "Error in Games");
    }
  }

  Future<dynamic> addGames(String gameID, String inGameName,[bool? update]) async {
    try {
      isLoading = true;
      Map<String, dynamic> data = {
        'game_id': gameID,
        "in_game_name": inGameName
      };
      log(update.toString(),name: "value of update");
      if (update==true){
        update=true;
      } else {
        update=false;
      }
      final responseData = await repo.addGames(data,update);
      if (responseData['status_code'] == 200) {
        showCustomToast(responseData['message']);
        return true;
      } else {
        log(responseData.toString(), name: 'Game adding Log');
      }
    } catch (e) {
      log("$e", name: "Error while adding games");
    }
  }

  Future<dynamic> userGames(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.userGames(offset);
      if (responseData['status_code'] == 200) {
        List<Games> tempList = List<Games>.from(
            responseData["data"]!.map((x) => Games.fromJson(x)));
        offset == 1 ? userGameList = tempList : userGameList += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Game List Log');
      }
    } catch (e) {
      log("$e", name: "Error in Games");
    }
  }

  Future<dynamic> deleteGames(String gameID) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.deleteGames(gameID);
      if (responseData['status_code'] == 200) {
        showCustomToast(responseData['message']);
        return true;
      } else {
        log(responseData.toString(), name: 'Game delete Log');
      }
    } catch (e) {
      log("$e", name: "Error in Games delete");
    }
  }
  
}
