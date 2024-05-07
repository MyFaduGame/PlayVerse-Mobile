//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class ArticlesRepo extends BaseRepository {

  Future articleList(int offset) async {
    final param = "?limit=10&offset=$offset";
    final response = await getHttp(
        api: ArticlesUrl.getArticles + param, token: true);
    log(response.body, name: 'response articleList');
    return json.decode(response.body);
  }

}