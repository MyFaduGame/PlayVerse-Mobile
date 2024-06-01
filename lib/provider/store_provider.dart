//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/stores_model.dart';
import 'package:playverse/repository/store_repo.dart';

class StoreProvider extends ChangeNotifier {
  
  final repo = StoreRepo();
  List<Products> productList = [];
  bool isLoading = false;

  Future<dynamic> getProducts(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getProducts(offset);
      if (responseData['status_code'] == 200) {
        List<Products> tempList = List<Products>.from(
            responseData["data"]!.map((x) => Products.fromJson(x)));
        productList = tempList;
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