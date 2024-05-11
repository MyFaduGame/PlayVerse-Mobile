//Third Party Imports
import 'dart:developer';
import 'package:flutter/material.dart';

//Local Imports
import 'package:playverse/models/tournaments_model.dart';
import 'package:playverse/repository/tournaments_repo.dart';
import 'package:playverse/utils/toast_bar.dart';

class TournamentsProvider extends ChangeNotifier {
  final repo = TournamentsRepo();
  List<TournamentDetail> tournamentList = [];
  List<TournamentDetail> userTournamentList = [];
  TournamentDetail? tournamentDetail;
  bool isLoading = false;

  Future<dynamic> getTournaments(int offset, String type) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData =
          await repo.getTournamentList(offset, type);
      if (responseData['status_code'] == 200) {
        List<TournamentDetail> tempList = List<TournamentDetail>.from(
            responseData["data"]!.map((x) => TournamentDetail.fromJson(x)));
        offset == 1 ? tournamentList = tempList : tournamentList += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'Tournaments Error Log');
      }
    } catch (e) {
      log("$e", name: "Tournaments List Error");
    }
  }

  Future<dynamic> getTournamentsDetail(String tournamentId) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData =
          await repo.getTournamentDetail(tournamentId);
      if (responseData['status_code'] == 200) {
        tournamentDetail = TournamentDetail.fromJson(responseData['data']);
        isLoading = false;
        notifyListeners();
        return tournamentDetail;
      } else {
        log(responseData.toString(), name: 'Tournaments Detail Error Log');
      }
    } catch (e) {
      log("$e", name: "Tournaments Detail List Error");
    }
  }

  Future<bool> soloRegistration(String tournamentId, String type) async {
    try {
      final response =
          await repo.soloTournamentRegistrtation(tournamentId, type);
      if (response['status_code'] == 200) {
        showCustomToast("Registration Done!");
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

  Future<dynamic> getUserTournaments(int offset) async {
    try {
      isLoading = true;
      Map<String, dynamic> responseData = await repo.getUserTournaments(offset);
      if (responseData['status_code'] == 200) {
        List<TournamentDetail> tempList = List<TournamentDetail>.from(
            responseData["data"]!.map((x) => TournamentDetail.fromJson(x)));
        offset == 1
            ? userTournamentList = tempList
            : userTournamentList += tempList;
        isLoading = false;
        notifyListeners();
        return tempList.length;
      } else {
        log(responseData.toString(), name: 'User Tournaments Detail Error Log');
      }
    } catch (e) {
      log("$e", name: "User Tournaments Detail List Error");
    }
  }
}
