import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/announcement.dart';

class AnnouncementModel extends Announcement {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    required super.datePosted,
    required super.author,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map, String id) {
    final createdAtValue = map['createdAt'];
    DateTime datePosted;
    if (createdAtValue is Timestamp) {
      datePosted = createdAtValue.toDate();
    } else if (createdAtValue is int) {
      datePosted = DateTime.fromMillisecondsSinceEpoch(createdAtValue);
    } else if (createdAtValue is String) {
      datePosted = DateTime.tryParse(createdAtValue) ?? DateTime.now();
    } else {
      datePosted = DateTime.now();
    }

    return AnnouncementModel(
      id: id,
      title: map['title'] as String? ?? '',
      content: map['body'] as String? ?? '',
      datePosted: datePosted,
      author: map['author'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': content,
      'createdAt': Timestamp.fromDate(datePosted),
      'author': author,
    };
  }
}