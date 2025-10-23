import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/event.dart';

// The EventModel class represents the data model for an event.
// It extends the Event entity from the domain layer, meaning it inherits all properties of Event.
// This class is responsible for converting data between Firestore documents and Dart objects.
class EventModel extends Event {
  // Constructor for EventModel that passes data to the parent (Event) constructor.
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
          location: location ?? '', // Defaults to an empty string if null
          imageUrl: imageUrl,
        );

  // ---------------------- FACTORY: FROM MAP ----------------------
  // Factory constructor that creates an EventModel from a Firestore document map.
  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    // Extracts the 'date' field and ensures it’s converted into a DateTime object.
    final dateValue = map['date'];
    DateTime date;

    // Handles multiple possible data formats for 'date' (Timestamp, int, String, or others).
    if (dateValue is Timestamp) {
      date = dateValue.toDate(); // Firestore Timestamp conversion
    } else if (dateValue is int) {
      date = DateTime.fromMillisecondsSinceEpoch(dateValue); // Milliseconds format
    } else if (dateValue is String) {
      date = DateTime.tryParse(dateValue) ?? DateTime.now(); // Parses string date
    } else {
      date = DateTime.now(); // Default fallback if none of the above
    }

    // Returns a new instance of EventModel with data safely extracted and parsed.
    return EventModel(
      id: id,
      title: map['title'] as String? ?? '', // Default to empty string if null
      description: map['description'] as String? ?? '',
      date: date,
      location: map['location'] as String?,
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }

  // ---------------------- TO MAP ----------------------
  // Converts an EventModel instance into a map that can be stored in Firestore.
  // it’s the bridge between your Flutter app’s objects and Firestore documents
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date), // Converts DateTime to Firestore Timestamp
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}
