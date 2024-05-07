//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/notification_model.dart';
import 'package:playverse/repository/notifications_repo.dart';

class NotificationProvider extends ChangeNotifier {

  final repo = NotificationRepo();
  List<Notifications> notifications = [];
  bool isLoading = false;

  Future<dynamic> getNotifications(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getNotifications(offset);
      if (responseData['status_code'] == 200) {
        List<Notifications> tempList = List<Notifications>.from(
            responseData["data"]!.map((x) => Notifications.fromJson(x)));
        notifications = tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Get Notification Logs');
      }
    } catch (e) {
      log("$e", name: "Error Fetching Notifications");
    }
  }
  
}
