class VideoData {
    final String? thumbnail;
    final String? id;

    VideoData({
        this.thumbnail,
        this.id,
    });

    factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        thumbnail: json["thumbnail"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "id": id,
    };
}

class Streams {
    final String? streamLink;
    final String? title;
    final DateTime? tournamentDate;
    final String? thumbnail;
    final String? logo;
    final String? gameName;

    Streams({
        this.streamLink,
        this.title,
        this.tournamentDate,
        this.thumbnail,
        this.gameName,
        this.logo
    });

    factory Streams.fromJson(Map<String, dynamic> json) => Streams(
        streamLink: json["stream_link"],
        title: json["title"],
        tournamentDate: json["tournament_date"] == null ? null : DateTime.parse(json["tournament_date"]),
        thumbnail: json["thumbnail"],
        gameName: json["game_name"],
        logo: json["logo"],
    );

}