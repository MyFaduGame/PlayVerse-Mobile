//Third Party Imports
import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String muxId;
  final MuxAsset? muxAsset;

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.muxId,
    this.muxAsset,
  });

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? createdAt,
    String? muxId,
    MuxAsset? muxAsset,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      muxId: muxId ?? this.muxId,
      muxAsset: muxAsset ?? this.muxAsset,
    );
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      muxId: json['muxId'],
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, createdAt, muxId, muxAsset];

  static List<Map<String, dynamic>> sampleVideos = [
    {
      "id": "1",
      "title": "Exploring the Mountains",
      "description": "A journey through the landscapes of the mountains.",
      "created_at": "2023-11-01",
      "muxId": "HZ7Zqucbi31RBgloSBL2wyM01wKXNqK5401q1Xvbtt9zE",
    },
    {
      "id": "2",
      "title": "Urban Adventures",
      "description": "Discover the hidden gems of city life.",
      "created_at": "2023-11-01",
      "muxId": "HZ7Zqucbi31RBgloSBL2wyM01wKXNqK5401q1Xvbtt9zE",
    },
    // {
    //   "id": "3",
    //   "title": "Ocean Wonders",
    //   "description": "Exploring the mysteries of the ocean.",
    //   "created_at": "2023-1-01",
    //   "muxId": "lvFJtlyIHd02NB2sZOv6301U8bspHlmphRENSvnNm6njA",
    // },
  ];
}

class MuxAsset {
  final String uploadId;
  final String playbackId;
  final Duration duration;
  final DateTime createdAt;

  const MuxAsset({
    required this.uploadId,
    required this.playbackId,
    required this.duration,
    required this.createdAt,
  });

  factory MuxAsset.fromJson(Map<String, dynamic> json) {
    final duration = Duration(milliseconds: (json['duration'] * 1000).toInt());
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
      int.parse(json['created_at']) * 1000,
    );
    return MuxAsset(
      uploadId: json['status'],
      playbackId: json['playback_ids'][0]['id'],
      duration: duration,
      createdAt: createdAt,
    );
  }
}
