//Third Party Imports
import 'dart:convert';
import 'dart:developer';
//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class GamesRepo extends BaseRepository {
  
  Future gamesListApi(int offset) async {
    String params = "?limit=12&offset=$offset";
    final response =
        await getHttp(api: GamesUrls.gamesList + params, token: true);
    log(response.body, name: 'response gamesListApi');
    return json.decode(response.body);
  }

  Future addGames(Map<String, dynamic> data,[bool? update]) async {
    String params = '';
    if (update==true) {
      params = "?update=$update";
    } else {
      params = "";
    }
    final response =
        await postHttp(api: GamesUrls.addGames + params, data: data, token: true);
    log(response.body, name: 'response addGames');
    return json.decode(response.body);
  }

  Future userGames(int offset) async {
    String params = "?limit=12&offset=$offset";
    final response =
        await getHttp(api: GamesUrls.userGames + params, token: true);
    log(response.body, name: 'response userGames');
    return json.decode(response.body);
  }

  Future deleteGames(String gameID) async {
    String params = "?game_id=$gameID";
    final response =
        await deleteHttp(api: GamesUrls.deleteGames + params, token: true);
    log(response.body, name: 'response deleteGames');
    return json.decode(response.body);
  }

}
