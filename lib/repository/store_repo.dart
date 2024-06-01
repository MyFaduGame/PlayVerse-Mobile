//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class StoreRepo extends BaseRepository {

  Future getProducts(int offset) async {
    final param = "?limit=10&offset=$offset";
    final response = await getHttp(
        api: StoreUrl.getProducts + param);
    log(response.body, name: 'response getProducts');
    return json.decode(response.body);
  }

}