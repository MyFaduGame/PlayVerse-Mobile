//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/repository/auth_repo.dart';
import 'package:playverse/utils/my_sharedprefrence.dart';
import 'package:playverse/utils/toast_bar.dart';

class UserAuthProvider extends ChangeNotifier {

  AuthRepository authRepo = AuthRepository();
  bool loggedIn = false;
  String userId = '';
  String accessToken = '';
  String refreshToken = '';
  bool userCheck(String user) => user == userId;

  Future<void> getToken() async {
    String? token =
        await MySharedPreferences.instance.getStringValue("access_token");
    String? uId = await MySharedPreferences.instance.getStringValue("user_id");
    userId = uId ?? '';
    loggedIn = token != null;
    log(userId.toString(), name: "User Id___");
    notifyListeners();
  }

  Future<bool> login(String email, String firebaseUid) async {
    try {
      Map<String, dynamic> data = {'email': email, 'firebase_uid': firebaseUid};
      final response = await authRepo.loginApi(data);
      if (response['status_code'] == 200) {
        userId = response["data"]["user_id"];
        accessToken = response["data"]["access_token"];
        refreshToken = response["data"]["refresh_token"];
        MySharedPreferences.instance.setStringValue("user_id", userId);
        MySharedPreferences.instance
            .setStringValue("access_token", accessToken);
        MySharedPreferences.instance
            .setStringValue("refresh_token", refreshToken);

        getToken();
        return true;
      } else {
        showCustomToast(response['message']);
        return false;
      }
    } catch (e) {
      showCustomToast('something went wrong!! $e');
    }
    return false;
  }

  Future<bool> register(String firebaseUid, String userName, String email,
      String firstName, String? referCode) async {
    try {
      Map<String, dynamic> data = {
        "firebase_uid": firebaseUid,
        'user_name': userName,
        'email': email,
        "first_name": firstName
      };
      if (referCode != null) {
        data['refer_code'] = referCode;
      }
      final response = await authRepo.registerApi(data);
      log(response.toString(), name: 'Response Register api');
      if (response != null && response['status_code'] == 200) {
        String accessToken = response["data"]["access_token"];
        String refreshToken = response["data"]["refresh_token"];
        String userId = response['data']["user_id"];

        MySharedPreferences.instance
            .setStringValue("access_token", accessToken);
        MySharedPreferences.instance
            .setStringValue("refresh_token", refreshToken);
        MySharedPreferences.instance.setStringValue("user_id", userId);
        showCustomToast(response['message']);

        return true;
      } else {
        showCustomToast(response['message']);
        return false;
      }
    } catch (e) {
      showCustomToast(e.toString());
      log(e.toString(), name: 'Error login');
    }
    showCustomToast('something went wrong!!');
    return false;
  }

}
