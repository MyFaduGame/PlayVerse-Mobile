class Achievements {
    final String? achievementsId;
    final String? achievementsTitle;
    final int? xpReward;
    final String? achievementsType;
    final String? achievementLinkId;
    final String? achievementsLogo;
    final bool? added;
    

    Achievements({
        this.achievementsId,
        this.achievementsTitle,
        this.xpReward,
        this.achievementsType,
        this.achievementLinkId,
        this.achievementsLogo,
        this.added,
    });

    factory Achievements.fromJson(Map<String, dynamic> json) => Achievements(
        achievementsId: json["achievements_id"],
        achievementsTitle: json["achievements_title"],
        xpReward: json["xp_reward"],
        achievementsType: json["achievements_type"],
        achievementLinkId: json["achievement_link_id"],
        achievementsLogo: json["achievement_logo"],
        added: json['added'],
    );
}