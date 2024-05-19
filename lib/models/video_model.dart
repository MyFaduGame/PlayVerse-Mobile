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