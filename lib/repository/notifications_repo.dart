//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class NotificationRepo extends BaseRepository {

  Future getNotifications(int offset) async {
      final param = "?limit=10&offset=$offset";
    final response = await getHttp(api: NotificationsUrl.getNotifications + param, token: true);
    log(response.body, name: 'response getNotifications');
    return json.decode(response.body);
  }



}
