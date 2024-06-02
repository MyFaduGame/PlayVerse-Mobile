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

class GemsData {
    final int? earned;
    final int? spent;
    final int? total;

    GemsData({
        this.earned,
        this.spent,
        this.total,
    });

    factory GemsData.fromJson(Map<String, dynamic> json) => GemsData(
        earned: json["Earned"],
        spent: json["Spent"],
        total: json["Total"],
    );

    Map<String, dynamic> toJson() => {
        "Earned": earned,
        "Spent": spent,
        "Total": total,
    };
}

class GemsInfo {
  final int? gemsAmount;
  final int? gemsPrize;

  GemsInfo({
    this.gemsAmount,
    this.gemsPrize,
  });

}
