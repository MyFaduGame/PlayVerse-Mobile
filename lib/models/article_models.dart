class Articles {
  final String? id;
  final String? title;
  final String? image;
  final String? description;
  final String? type;
  final DateTime? articleDate;

  Articles({
    this.id,
    this.title,
    this.image,
    this.description,
    this.type,
    this.articleDate,
  });

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        id: json["id"],
        title: json["Title"],
        image: json["Image"],
        description: json["Description"],
        type: json["Type"],
        articleDate: json["article_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["article_date"]),
      );
}
