class UserProfile {
  final String? userId;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? gender;
  final String? profileImage;
  final DateTime? lastLogin;
  final String? email;
  final String? mobile;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;
  final String? instaURL;
  final String? fbURL;
  final String? ytURL;
  final String? twURL;
  final int? expirence;
  final int? coins;
  final double? xp;
  final String? referCode;

  UserProfile(
      {this.fbURL,
      this.instaURL,
      this.twURL,
      this.ytURL,
      this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.dob,
      this.gender,
      this.profileImage,
      this.lastLogin,
      this.email,
      this.mobile,
      this.city,
      this.state,
      this.country,
      this.pinCode,
      this.coins,
      this.expirence,
      this.referCode,
      this.xp});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      userId: json["user_id"],
      userName: json["user_name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      dob: json["dob"],
      gender: json["gender"],
      profileImage: json["profile_image"],
      lastLogin: json["last_login"] == null
          ? null
          : DateTime.parse(json["last_login"]),
      email: json["email"],
      mobile: json["mobile"],
      city: json["city_name"],
      state: json["state_name"],
      country: json["country_name"],
      pinCode: json["pin_code"],
      fbURL: json['fb_link'],
      instaURL: json['insta_link'],
      twURL: json['twitch_link'],
      ytURL: json['yt_link'],
      coins: json['coins'],
      expirence: json['expirence'],
      referCode: json['refer_code'],
      xp: json['xp']);
}

class UserProfileVisit {
  final String? userId;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? profileImage;
  final String? city;
  final String? state;
  final String? country;
  final String? instaURL;
  final String? fbURL;
  final String? ytURL;
  final String? twURL;
  final int? expirence;
  final String? referCode;

  UserProfileVisit(
      {this.fbURL,
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
      this.expirence,
      this.referCode});

  factory UserProfileVisit.fromJson(Map<String, dynamic> json) => UserProfileVisit(
      userId: json["user_id"],
      userName: json["user_name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      gender: json["gender"],
      profileImage: json["profile_image"],
      city: json["city_name"],
      state: json["state_name"],
      country: json["country_name"],
      fbURL: json['fb_link'],
      instaURL: json['insta_link'],
      twURL: json['twitch_link'],
      ytURL: json['yt_link'],
      expirence: json['expirence'],
      referCode: json['refer_code']);
}

