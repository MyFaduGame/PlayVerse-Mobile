class Notifications {
  final String? message;
  final bool? read;
  final DateTime? date;

  Notifications({
    this.message,
    this.read,
    this.date,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        message: json["message"],
        read: json["read"] ?? false,
        date: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );
}
