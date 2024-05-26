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

    Streams({
        this.streamLink,
        this.title,
        this.tournamentDate,
        this.thumbnail,
    });

    factory Streams.fromJson(Map<String, dynamic> json) => Streams(
        streamLink: json["stream_link"],
        title: json["title"],
        tournamentDate: json["tournament_date"] == null ? null : DateTime.parse(json["tournament_date"]),
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "stream_link": streamLink,
        "title": title,
        "tournament_date": tournamentDate?.toIso8601String(),
        "thumbnail": thumbnail,
    };
}