//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class FriendsRepo extends BaseRepository {
  Future friendsRecomendApi(int offset) async {
    final params = '?offset=$offset&limit=10';
    final response =
        await getHttp(api: FriendsUrl.recommandedFriends+params, token: true);
    log(response.body, name: 'response friendsRecomendApi');
    return json.decode(response.body);
  }

  Future ownFriendsApi(int offset) async {
    final params = '?offset=$offset&limit=10';
    final response =
        await getHttp(api: FriendsUrl.ownFriends + params, token: true);
    log(response.body, name: 'response ownFriendsApi');
  return json.decode(response.body);
  }

  Future addFriends(String friendID) async {
    final params = "?user_friend_id=$friendID";
    final response = await getHttp(api: FriendsUrl.addFriends + params,token: true);
    log(response.body, name: 'response addFriends');
    return json.decode(response.body);
  }

  Future acceptRequest(String friendID,bool accept) async {
    final params = "?friend_id=$friendID&accepted=$accept";
    final response = await getHttp(api: FriendsUrl.acceptRequests + params,token: true);
    log(response.body, name: 'response acceptRequest');
    return json.decode(response.body);
  }

  Future getFriendRequests(int offset) async {
    final params = '?offset=$offset&limit=10';
    final response = await getHttp(api: FriendsUrl.friendRequests + params,token: true);
    log(response.body, name: 'response getFriendRequests');
    return json.decode(response.body);
  }

  Future getSentFriendRequests(int offset) async {
    final params = '?offset=$offset&limit=10';
    final response = await getHttp(api: FriendsUrl.sentRequests + params,token: true);
    log(response.body, name: 'response getSentFriendRequests');
    return json.decode(response.body);
  }

}
