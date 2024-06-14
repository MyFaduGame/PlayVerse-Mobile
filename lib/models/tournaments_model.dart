class Tournaments {
  final String? tournamentId;
  final String? title;
  final String? gener;
  final PrizePool? prizePool;
  final int? registrationFee;
  final DateTime? tournamentDate;
  final DateTime? registrationClose;
  final String? gameName;
  final String? isRegistrationOpen;
  final String? logo;

  Tournaments(
      {this.tournamentId,
      this.title,
      this.gener,
      this.prizePool,
      this.registrationFee,
      this.tournamentDate,
      this.registrationClose,
      this.gameName,
      this.isRegistrationOpen,
      this.logo});

  factory Tournaments.fromJson(Map<String, dynamic> json) => Tournaments(
        tournamentId: json["tournament_id"],
        title: json["title"],
        gener: json["gener"],
        prizePool: json["prize_pool"] == null
            ? null
            : PrizePool.fromJson(json["prize_pool"]),
        registrationFee: json["registration_fee"],
        tournamentDate: json["tournament_date"] == null
            ? null
            : DateTime.parse(json["tournament_date"]),
        registrationClose: json["registration_close"] == null
            ? null
            : DateTime.parse(json["registration_close"]),
        gameName: json["game_name"],
        isRegistrationOpen: json["is_registration_open"],
        logo: json["logo"],
      );
}

class TournamentDetail {
  final String? tournamentId;
  final String? title;
  final String? gener;
  final PrizePool? prizePool;
  final ExtraPrize? extraPrize;
  final int? registrationFee;
  final int? maxPlayers;
  final int? playerLeft;
  final DateTime? registrationOpens;
  final DateTime? registrationClose;
  final DateTime? tournamentDate;
  final String? thumbnail;
  final String? registrationType;
  final String? gameName;
  final String? logo;
  final String? invitationCode;
  final String? isRegistrationOpen;
  final String? registrationId;

  TournamentDetail({
    this.tournamentId,
    this.title,
    this.gener,
    this.prizePool,
    this.extraPrize,
    this.registrationFee,
    this.maxPlayers,
    this.playerLeft,
    this.registrationOpens,
    this.registrationClose,
    this.tournamentDate,
    this.thumbnail,
    this.registrationType,
    this.gameName,
    this.logo,
    this.invitationCode,
    this.isRegistrationOpen,
    this.registrationId,
  });

  factory TournamentDetail.fromJson(Map<String, dynamic> json) =>
      TournamentDetail(
        tournamentId: json["tournament_id"],
        title: json["title"],
        gener: json["gener"],
        prizePool: json["prize_pool"] == null
            ? null
            : PrizePool.fromJson(json["prize_pool"]),
        extraPrize: json["extra_prize"] == null
            ? null
            : ExtraPrize.fromJson(json["extra_prize"]),
        registrationFee: json["registration_fee"],
        maxPlayers: json["max_players"],
        playerLeft: json["player_left"],
        registrationOpens: json["registration_opens"] == null
            ? null
            : DateTime.parse(json["registration_opens"]),
        registrationClose: json["registration_close"] == null
            ? null
            : DateTime.parse(json["registration_close"]),
        tournamentDate: json["tournament_date"] == null
            ? null
            : DateTime.parse(json["tournament_date"]),
        thumbnail: json["thumbnail"],
        registrationType: json["registration_type"],
        gameName: json["game_name"],
        logo: json["logo"],
        invitationCode: json["invitation_code"],
        isRegistrationOpen: json["is_registration_open"],
        registrationId: json["registration_id"],
      );
}

class PrizePool {
  final String? the1St;
  final String? the2nd;
  final String? the3rd;

  PrizePool({this.the1St, this.the2nd, this.the3rd});

  factory PrizePool.fromJson(Map<String, dynamic> json) =>
      PrizePool(the1St: json["1st"], the2nd: json["2nd"], the3rd: json["3rd"]);
}

class ExtraPrize {
  final String? the1St;
  final String? the2nd;
  final String? the3rd;

  ExtraPrize({this.the1St, this.the2nd, this.the3rd});

  factory ExtraPrize.fromJson(Map<String, dynamic> json) =>
      ExtraPrize(the1St: json["1st"], the2nd: json["2nd"], the3rd: json["3rd"]);
}

class TournamentWinner {
  final int? winRank;
  final int? totalScore;
  final String? title;
  final String? tournamentId;
  final String? thumbnail;
  final dynamic profileImage;
  final String? userId;
  final String? userName;

  TournamentWinner({
    this.winRank,
    this.totalScore,
    this.title,
    this.tournamentId,
    this.thumbnail,
    this.profileImage,
    this.userId,
    this.userName,
  });

  factory TournamentWinner.fromJson(Map<String, dynamic> json) =>
      TournamentWinner(
        winRank: json["win_rank"],
        totalScore: json["total_score"],
        title: json["title"],
        tournamentId: json["tournament_id"],
        thumbnail: json["thumbnail"],
        profileImage: json["profile_image"],
        userId: json["user_id"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "win_rank": winRank,
        "total_score": totalScore,
        "title": title,
        "tournament_id": tournamentId,
        "thumbnail": thumbnail,
        "profile_image": profileImage,
        "user_id": userId,
        "user_name": userName,
      };
}
