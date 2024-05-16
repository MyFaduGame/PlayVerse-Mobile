//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playverse/repository/course_repo.dart';

//Local Imports
import 'package:playverse/utils/my_sharedprefrence.dart';
import 'package:playverse/utils/toast_bar.dart';

class CourserProvider extends ChangeNotifier {
  CourseRepo courseRepo = CourseRepo();

  Future<bool> register(
      String email, String description, String gameName, String mobile) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        'mobile': mobile,
        'game': gameName,
        "description": description
      };
      final response = await courseRepo.courseInfo(data);
      log(response.toString(), name: 'Response Register api');
      if (response['status_code'] == 200) {
        showCustomToast(response['message']);
        return true;
      } else {
        showCustomToast(response['message']);
        return false;
      }
    } catch (e) {
      showCustomToast(e.toString());
      log(e.toString(), name: 'Error Sending Course Info!');
    }
    showCustomToast('something went wrong!!');
    return false;
  }
}
