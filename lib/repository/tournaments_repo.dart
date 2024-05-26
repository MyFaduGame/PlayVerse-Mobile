//Third Party Imports
import 'dart:convert';
import 'dart:developer';

//Local Imports
import 'package:playverse/repository/base_repo.dart';
import 'package:playverse/utils/app_urls.dart';

class TournamentsRepo extends BaseRepository {
  
  Future getTournamentList(int offset, String type) async {
    final param = "?limit=10&offset=$offset&registration_type=$type";
    final response = await getHttp(
        api: TournamentsUrl.getTournamentsList + param, token: true);
    log(response.body, name: 'response getTournamentList');
    return json.decode(response.body);
  }

  Future getGamesTournamentList(int offset, String gameUUID) async {
    final param = "?limit=10&offset=$offset&games=$gameUUID";
    final response = await getHttp(
        api: TournamentsUrl.getTournamentsList + param, token: true);
    log(response.body, name: 'response getTournamentList');
    return json.decode(response.body);
  }

  Future getTournamentWinner(String tournamentId) async {
    final param = "?tournament_id=$tournamentId";
    final response = await getHttp(
        api: TournamentsUrl.tournamentWinner + param, token: true);
    log(response.body, name: 'response getTournamentWinner');
    return json.decode(response.body);
  }

  Future getTournamentDetail(String tournamentId) async {
    final param = "?tournament_id=$tournamentId";
    final response = await getHttp(
        api: TournamentsUrl.getTournamentDetail + param, token: true);
    log(response.body, name: 'response getTournamentDetail');
    return json.decode(response.body);
  }

  Future soloTournamentRegistrtation(String tournamentId,String type) async {
    final params = "?tournament_id=$tournamentId&solo_team=$type";
    final response = await postHttp(
        data: {},
        api: TournamentsUrl.soloTournamentRegistrtation + params,
        token: true);
    log(response.body, name: "response soloTournamentRegistration");
    return json.decode(response.body);
  }

  Future getUserTournaments(int offset) async {
    final param = "?limit=10&offset=$offset";
    final response = await getHttp(
        api: TournamentsUrl.userTournaments + param, token: true);
    log(response.body, name: 'response getUserTournaments');
    return json.decode(response.body);
  }

}
