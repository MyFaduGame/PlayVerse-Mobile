//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class VideoRepo extends BaseRepository {
  Future getStreams(int offset) async {
    String params = "?limit=12&offset=$offset";
    final response =
        await getHttp(api: StreamsUrl.getStream + params, token: false);
    log(response.body, name: 'response getStreams');
    return json.decode(response.body);
  }
}
