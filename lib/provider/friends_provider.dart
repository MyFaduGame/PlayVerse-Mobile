//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/friends_model.dart';
import 'package:playverse/repository/friends_repo.dart';
import 'package:playverse/utils/toast_bar.dart';

class FriendListProvider extends ChangeNotifier {
  
  final repo = FriendsRepo();
  List<Friend> ownFriend = [];
  List<Friend> recommendFriend = [];
  List<FriendRequest> friendRequests = [];
  bool isLoading = false;

  Future<dynamic> getFriendsProvider(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.friendsRecomendApi(offset);
      if (responseData['status_code'] == 200) {
        if(responseData['data']==null){
          return recommendFriend;
        }
        List<Friend> tempList = List<Friend>.from(
            responseData["data"]!.map((x) => Friend.fromJson(x)));
        offset == 1 ? recommendFriend = tempList : recommendFriend += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Recomended Friend Log');
      }
    } catch (e) {
      log("$e", name: "Error Fetching Recommanded Friend");
    }
  }

  Future<dynamic> getOwnFriendsProvider(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.ownFriendsApi(offset);
      if (responseData['status_code'] == 200) {
        if(responseData['data']==null){
          return ownFriend;
        }
        List<Friend> tempList = List<Friend>.from(
            responseData["data"]!.map((x) => Friend.fromJson(x))).toList();
        offset == 1 ? ownFriend = tempList : ownFriend += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Get user Friends Log');
      }
    } catch (e) {
      log("$e", name: "Error Fetching User Friends");
    }
  }

  Future<dynamic> addFriends(String friendID) async {
    try {
      isLoading = true;
      final responseData = await repo.addFriends(friendID);
      if (responseData['status_code'] == 200) {
        showCustomToast(responseData['message']);
        return true;
      } else if (responseData['status_code'] == 400) {
        showCustomToast(responseData['message']);
        return false;
      } else {
        log(responseData.toString(), name: 'Friends adding Log');
      }
    } catch (e) {
      log("$e", name: "Error while adding friend");
    }
  }

  Future<dynamic> getFriendRequests(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getFriendRequests(offset);
      if (responseData['status_code'] == 200) {
        if(responseData['data']==null){
          return friendRequests;
        }
        List<FriendRequest> tempList = List<FriendRequest>.from(
            responseData["data"]!.map((x) => FriendRequest.fromJson(x)));
        offset == 1 ? friendRequests = tempList : friendRequests += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Recomended Friend Log');
      }
    } catch (e) {
      log("$e", name: "Error Fetching Recommanded Friend");
    }
  }
}
