import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/announcement.dart';

// The AnnouncementModel class represents an Announcement object for Firestore operations
// It extends the base Announcement entity and includes conversion methods (fromMap, toMap)
class AnnouncementModel extends Announcement {
  // Constructor: initializes an AnnouncementModel with required fields
  // The 'super' keyword passes the values to the parent class (Announcement)
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    required super.datePosted,
    required super.author,
  });

  // Factory constructor to create an AnnouncementModel from a Firestore document (Map + ID)
  factory AnnouncementModel.fromMap(Map<String, dynamic> map, String id) {
    // Retrieve the 'createdAt' value from the map (it can be Timestamp, int, String, etc.)
    final createdAtValue = map['createdAt'];

    // Declare a variable to store the parsed DateTime value
    DateTime datePosted;

    // Check the data type of 'createdAt' and convert accordingly
    if (createdAtValue is Timestamp) {
      // If it's a Firestore Timestamp, convert it to a Dart DateTime
      datePosted = createdAtValue.toDate();
    } else if (createdAtValue is int) {
      // If it's stored as milliseconds since epoch (int), convert it to DateTime
      datePosted = DateTime.fromMillisecondsSinceEpoch(createdAtValue);
    } else if (createdAtValue is String) {
      // If it's stored as a String, attempt to parse it into a DateTime
      // If parsing fails, use the current date and time
      datePosted = DateTime.tryParse(createdAtValue) ?? DateTime.now();
    } else {
      // If none of the above match, default to the current date and time
      datePosted = DateTime.now();
    }

    // Return a new AnnouncementModel instance with safely extracted and converted values
    return AnnouncementModel(
      id: id,                                           // Document ID from Firestore
      title: map['title'] as String? ?? '',             // Title field (default empty string if null)
      content: map['body'] as String? ?? '',            // Body/content field (default empty string if null)
      datePosted: datePosted,                           // Converted 'createdAt' timestamp
      author: map['author'] as String? ?? '',           // Author field (default empty string if null)
    );
  }

  // Convert the AnnouncementModel instance into a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,                                   // Store the title
      'body': content,                                  // Store the content/body
      'createdAt': Timestamp.fromDate(datePosted),      // Convert DateTime back to Firestore Timestamp
      'author': author,                                 // Store the author name
    };
  }
}
