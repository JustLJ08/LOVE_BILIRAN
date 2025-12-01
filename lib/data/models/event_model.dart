import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/event.dart';

class EventModel extends LocalEvent {
  const EventModel({
    required super.id,
    required super.title,
    required super.date,
    required super.location,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'date': Timestamp.fromDate(date),
      'location': location,
    };
  }
}