//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/article_models.dart';
import 'package:playverse/repository/article_repo.dart';

class ArticlesProvider extends ChangeNotifier {
  
  final repo = ArticlesRepo();
  List<Articles> articlesList = [];
  bool isLoading = false;

  Future<dynamic> getArticles(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.articleList(offset);
      if (responseData['status_code'] == 200) {
        List<Articles> tempList = List<Articles>.from(
            responseData["data"]!.map((x) => Articles.fromJson(x)));
        articlesList = tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Articles Error Log');
      }
    } catch (e) {
      log("$e", name: "Articles List Error");
    }
  }
}