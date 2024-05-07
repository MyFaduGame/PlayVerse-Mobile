//Third Party Imports
import 'dart:convert';
import 'dart:developer';
//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class UserProfileRepo extends BaseRepository {
  
  Future userProfileApi() async {
    final response = await getHttp(api: UserUrls.userProfile, token: true);
    log(response.body, name: 'response userProfileApi');
    return json.decode(response.body);
  }

  Future userProfileVisitApi(String userID) async {
    final params = "?user_id=$userID";
    final response = await getHttp(api: UserUrls.userProfile+params, token: true);
    log(response.body, name: 'response userProfileVisitApi');
    return json.decode(response.body);
  }

  Future updateProfileApi(Map<String, dynamic> data) async {
    final response = await postHttp(api: UserUrls.userProfile,data: data, token: true);
    log(response.body, name: 'response userProfileApi');
    return json.decode(response.body);
  }

}
