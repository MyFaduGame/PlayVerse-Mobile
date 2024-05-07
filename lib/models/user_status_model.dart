class UserStatus {
  final String profileImage;
  final String userId;
  final String userStatus;

  UserStatus({
    required this.profileImage,
    required this.userId,
    required this.userStatus,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        profileImage: json["profile_image"]??"",
        userId: json["user_id"],
        userStatus: json["user_status"],
      );
}
