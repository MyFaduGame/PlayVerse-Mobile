//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class AcheivementsRepo extends BaseRepository {

  Future userAchievements(int offset) async {
    final param = "?limit=12&offset=$offset";
    final response = await getHttp(
        api: AchievementsUrl.userAchievements + param, token: true);
    log(response.body, name: 'response userAchievements');
    return json.decode(response.body);
  }

  Future allAchievements(int offset) async {
    final param = "?limit=12&offset=$offset";
    final response = await getHttp(
        api: AchievementsUrl.allAchievements + param, token: true);
    log(response.body, name: 'response allAchievements');
    return json.decode(response.body);
  }

}
