//Third Party Imports
import 'dart:convert';
import 'dart:developer';
//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class AuthRepository extends BaseRepository {
  Future loginApi(Map<String, dynamic> data) async {
    final response = await postHttp(api: UserUrls.userLogin, data: data);
    log(response.body, name: 'response loginApi');
    return json.decode(response.body);
  }

  Future registerApi(Map<String, dynamic> data) async {
    final response = await postHttp(data: data, api: UserUrls.userRegistration);
    log(response.body, name: 'response registerApi');
    return json.decode(response.body);
  }
}