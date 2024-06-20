//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class StoreRepo extends BaseRepository {
  Future getProducts(int offset) async {
    final param = "?limit=10&offset=$offset";
    final response = await getHttp(api: StoreUrl.getProducts + param);
    log(response.body, name: 'response getProducts');
    return json.decode(response.body);
  }

  Future getCategoryProduct(int offset,String categoryID) async {
    final param = "?limit=10&offset=$offset&category_id=$categoryID";
    final response = await getHttp(api: StoreUrl.getProducts + param);
    log(response.body, name: 'response getCategoryProduct');
    return json.decode(response.body);
  }

  Future getCart() async {
    final response = await getHttp(api: StoreUrl.getCart, token: true);
    log(response.body, name: 'response getCart');
    return json.decode(response.body);
  }

  Future addToCart(Map<String, dynamic> data) async {
    final response =
        await postHttp(api: StoreUrl.getCart, data: data, token: true);
    log(response.body, name: 'response addToCart');
    return json.decode(response.body);
  }
}
