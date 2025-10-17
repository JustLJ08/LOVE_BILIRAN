import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    String? location,
    required String imageUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          date: date,
          location: location ?? '',
          imageUrl: imageUrl,
        );

  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    final dateValue = map['date'];
    DateTime date;
    if (dateValue is Timestamp) {
      date = dateValue.toDate();
    } else if (dateValue is int) {
      date = DateTime.fromMillisecondsSinceEpoch(dateValue);
    } else if (dateValue is String) {
      date = DateTime.tryParse(dateValue) ?? DateTime.now();
    } else {
      date = DateTime.now();
    }

    return EventModel(
      id: id,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      date: date,
      location: map['location'] as String?,
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}