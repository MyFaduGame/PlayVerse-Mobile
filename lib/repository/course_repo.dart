//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class CourseRepo extends BaseRepository {
  Future courseInfo(Map<String, dynamic> data) async {
    final response =
        await postHttp(api: CourseUrl.courseInfo, data: data, token: true);
    log(response.body, name: 'response courserInfo');
    return json.decode(response.body);
  }
}
