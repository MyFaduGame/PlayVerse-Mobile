//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Local Imports
import 'package:playverse/models/location_model.dart';
import 'package:playverse/repository/location_repository.dart';

class LocationProvider extends ChangeNotifier {
  final repo = LocationRepo();
  List<Country>? countryData = [];
  List<States>? stateData = [];
  List<City>? cityData = [];
  bool isLoading = false;

  Future<dynamic> getCountry() async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.countryApi();
      if (responseData['status_code'] == 200) {
        countryData = List<Country>.from(
            responseData["data"]!.map((x) => Country.fromJson(x)));
        // countryData = tempList;
        isLoading = false;
        notifyListeners();
        return countryData;
      } else {
        log(responseData.toString(), name: 'Country Logs');
      }
    } catch (e) {
      log("$e", name: "Error in Country Get");
    }
  }

  Future<dynamic> getState(String countryId) async {
    try {
      Map<String, dynamic> data = {'country': countryId};
      isLoading = true;
      Map<String, dynamic> responseData = await repo.stateApi(data);
      if (responseData['status_code'] == 200) {
        stateData = List<States>.from(
            responseData["data"]!.map((x) => States.fromJson(x)));
        // stateData = tempList;
        isLoading = false;
        notifyListeners();
        return stateData;
      } else {
        log(responseData.toString(), name: 'State Logs');
      }
    } catch (e) {
      log("$e", name: "Error in State Get");
    }
  }

  Future<dynamic> getCity(String stateId) async {
    try {
      Map<String, dynamic> data = {'state': stateId};
      isLoading = true;
      Map<String, dynamic> responseData = await repo.cityApi(data);
      if (responseData['status_code'] == 200) {
        cityData=
            List<City>.from(responseData["data"]!.map((x) => City.fromJson(x)));
        // cityData = tempList;
        isLoading = false;
        notifyListeners();
        return cityData;
      } else {
        log(responseData.toString(), name: 'City Logs');
      }
    } catch (e) {
      log("$e", name: "Error in City Get");
    }
  }
}
