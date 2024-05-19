//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class LocationRepo extends BaseRepository {
  Future countryApi() async {
    final response = await getHttp(api: LocationUrl.country, token: false);
    log(response.body, name: 'response countryApi');
    return json.decode(response.body);
  }

  Future stateApi(Map<String, dynamic> data) async {
    final response = await postHttp(api: LocationUrl.state, data: data);
    log(response.body, name: 'response stateApi');
    return json.decode(response.body);
  }

  Future cityApi(Map<String, dynamic> data) async {
    final response = await postHttp(api: LocationUrl.city, data: data);
    log(response.body, name: 'response cityApi');
    return json.decode(response.body);
  }
}
