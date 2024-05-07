//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/user_status_model.dart';
import 'package:playverse/repository/firebase_api.dart';
import 'package:playverse/repository/user_status_repo.dart';

class UserStatusProvider extends ChangeNotifier {

  final repo = UserStatusRepo();
  List<UserStatus>? userStatusModel;
  bool isLoading = false;

  Future<dynamic> getFriendsProvider() async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.userFriendsStatus();
      if (responseData['status_code'] == 200) {
        userStatusModel = List<UserStatus>.from(
            responseData["data"]!.map((x) => UserStatus.fromJson(x)));
        isLoading = false;
        notifyListeners();
        return userStatusModel;
      } else {
        log(responseData.toString(), name: 'Logging for Friends Status');
      }
    } catch (e) {
      log("$e", name: "Error in Geting Friend Status");
    }
  }

  Future<dynamic> userOwnStatus(bool userstatus) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.userOwnStatus(userstatus);
      if (responseData['status_code'] == 200) {
        isLoading = false;
        notifyListeners();
        return true;
      } else if (responseData['status_code'] == 403){
        signOut();
      } else {
        log(responseData.toString(), name: 'Logging for Own Status');
      }
    } catch (e) {
      log("$e", name: "Error in Setting Own Status");
    }
  }
  
}
