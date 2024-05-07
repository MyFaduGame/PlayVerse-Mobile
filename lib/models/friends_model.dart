class Friend {
  final String? userId;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? profileImage;
  final String? city;
  final String? state;
  final String? country;
  final String? teamName;
  final UserTeam? userTeam;
  final String? instaURL;
  final String? fbURL;
  final String? ytURL;
  final String? twURL;
  final int? expirence;
  final String? referCode;

  Friend({
    this.fbURL,
    this.instaURL,
    this.twURL,
    this.ytURL,
    this.userId,
    this.userName,
    this.firstName,
    this.lastName,
    this.gender,
    this.profileImage,
    this.city,
    this.state,
    this.country,
    this.teamName,
    this.userTeam,
    this.expirence,
    this.referCode,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        userId: json["user_id"],
        userName: json["user_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        profileImage: json["profile_image"],
        city: json["city_name"],
        state: json["state_name"],
        country: json["country_name"],
        teamName: json["team_name"],
        userTeam: json["user_team"] == null
            ? null
            : UserTeam.fromJson(json["user_team"]),
        fbURL: json['fb_link'],
        instaURL: json['insta_link'],
        twURL: json['twitch_link'],
        ytURL: json['yt_link'],
        expirence: json['expirence'],
        referCode: json['refer_code'],
      );
}

class FriendRequest {
    final String? friendsId;
    final String? userId;
    final String? userFriendId;
    final bool? accepted;
    final String? userName;
    final String? profileImage;
    final String? gender;

    FriendRequest({
        this.friendsId,
        this.userId,
        this.userFriendId,
        this.accepted,
        this.userName,
        this.profileImage,
        this.gender,
    });

    factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        friendsId: json["friends_id"],
        userId: json["user_id"],
        userFriendId: json["user_friend_id"],
        accepted: json["accepted"],
        userName: json["user_name"],
        profileImage: json["profile_image"],
        gender: json["gender"],
    );

}

class UserTeam {
  final String? memberId;
  final String? userId;
  final String? teamId;
  final DateTime? joinDate;

  UserTeam({
    this.memberId,
    this.userId,
    this.teamId,
    this.joinDate,
  });

  factory UserTeam.fromJson(Map<String, dynamic> json) => UserTeam(
        memberId: json["member_id"],
        userId: json["user_id"],
        teamId: json["team_id"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
      );
}
