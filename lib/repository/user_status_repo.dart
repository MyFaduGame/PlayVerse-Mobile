//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class UserStatusRepo extends BaseRepository {
  
  Future userFriendsStatus() async {
    final response = await getHttp(api: UserStatusUrl.userFriendsStatus, token: true);
    log(response.body, name: 'response userFriendsStatus');
    return json.decode(response.body);
  }

  Future userOwnStatus(bool userstatus) async {
    final params = '?userstatus=$userstatus';
    final response = await getHttp(api: UserStatusUrl.userOwnStatus+params, token: true);
    log(response.body, name: 'response userOwnStatus');
    return json.decode(response.body);
  }

}