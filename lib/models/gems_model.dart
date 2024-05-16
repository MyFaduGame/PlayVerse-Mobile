class Gems {
  final int? gemAmount;
  final String? userId;
  final String? title;
  final String? gemsId;

  Gems({
    this.gemAmount,
    this.userId,
    this.title,
    this.gemsId,
  });

  factory Gems.fromJson(Map<String, dynamic> json) => Gems(
        gemAmount: json["gem_amount"],
        userId: json["user_id"],
        title: json["title"],
        gemsId: json["gems_id"],
      );
}
