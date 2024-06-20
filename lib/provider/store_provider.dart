//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/stores_model.dart';
import 'package:playverse/repository/store_repo.dart';
import 'package:playverse/utils/toast_bar.dart';

class StoreProvider extends ChangeNotifier {
  final repo = StoreRepo();
  List<Products> productList = [];
  List<Products> categroyProductList = [];
  List<Cart>? cartList;
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
        log(responseData.toString(), name: 'Products Error Log');
      }
    } catch (e) {
      log("$e", name: "Products List Error");
    }
  }

  Future<dynamic> getCategoryProduct(int offset,String categroyID) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getCategoryProduct(offset,categroyID);
      if (responseData['status_code'] == 200) {
        List<Products> tempList = List<Products>.from(
            responseData["data"]!.map((x) => Products.fromJson(x)));
        productList = tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Products Error Log');
      }
    } catch (e) {
      log("$e", name: "Products List Error");
    }
  }

  Future<dynamic> getCart() async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getCart();
      if (responseData['status_code'] == 200) {
        cartList = List<Cart>.from(
            responseData["data"]["products"]!.map((x) => Cart.fromJson(x)));
        isLoading = false;
        notifyListeners();
        return cartList;
      } else {
        log(responseData.toString(), name: 'Cart Error Log');
      }
    } catch (e) {
      log("$e", name: "Cart List Error");
    }
  }

  Future<bool> addToCart(String productId) async {
    try {
      Map<String, dynamic> data = {'product_id': productId};
      final response = await repo.addToCart(data);
      if (response['status_code'] == 200) {
        showCustomToast(response["message"]);
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
}
