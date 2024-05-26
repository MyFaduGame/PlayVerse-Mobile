//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class GemsRepo extends BaseRepository {

  Future getUserGems(int offset,String type) async {
    final param = "?limit=12&offset=$offset&gem_type=$type";
    final response = await getHttp(
        api: GemsUrl.getGemsList + param, token: true);
    log(response.body, name: 'response userGems');
    return json.decode(response.body);
  }

  Future getUserGemsData() async {
    final response = await getHttp(
        api: GemsUrl.getUserGemsData, token: true);
    log(response.body, name: 'response getUserGemsData');
    return json.decode(response.body);
  }

}
