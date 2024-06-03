//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/utils/toast_bar.dart';
import 'package:playverse/repository/course_repo.dart';

class CourseProvider extends ChangeNotifier {
  CourseRepo courseRepo = CourseRepo();

  Future<bool> register(
      String email, String description, String gameName, String mobile) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "mobile": mobile,
        "game": gameName,
        "description": description
      };
      log("data is correct",name: "data correct");
      final response = await courseRepo.courseInfo(data);
      log("response",name: "response");
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
