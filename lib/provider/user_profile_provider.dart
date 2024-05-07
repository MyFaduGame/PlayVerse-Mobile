//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/user_profile_model.dart';
import 'package:playverse/repository/user_profile_repo.dart';

class UserProfileProvider extends ChangeNotifier {
  
  final repo = UserProfileRepo();
  UserProfile? userModel;
  UserProfileVisit? userProfileVisit;
  bool isLoading = false;

  Future<dynamic> getProfileInfoProvider() async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.userProfileApi();
      if (responseData['status_code'] == 200) {
        userModel = UserProfile.fromJson(responseData['data']);
        isLoading = false;
        notifyListeners();
        return userModel;
      } else {
        log(responseData.toString(), name: 'User Profile Logs');
      }
    } catch (e) {
      log("$e", name: "Error in User Profile Get");
    }
  }

  Future<dynamic> getUserProfileVisitProvider(String userID) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData =
          await repo.userProfileVisitApi(userID);
      if (responseData['status_code'] == 200) {
        userProfileVisit = UserProfileVisit.fromJson(responseData['data']);
        isLoading = false;
        notifyListeners();
        return userProfileVisit;
      } else {
        log(responseData.toString(), name: 'User Profile Visit Logs');
      }
    } catch (e) {
      log("$e", name: "Error in User Profile Visit Get");
    }
  }

  Future<dynamic> updateProfileProvider(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.updateProfileApi(data);
      if (responseData['status_code'] == 200) {
        userModel = UserProfile.fromJson(responseData['data']);
        isLoading = false;
        notifyListeners();
        return userModel;
      } else {
        log(responseData.toString(), name: 'User Profile Logs');
      }
    } catch (e) {
      log("$e", name: "Error in User Profile Get");
    }
  }
}
