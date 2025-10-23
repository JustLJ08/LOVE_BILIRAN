import '../../domain/entities/tourist_spot.dart';

// This model represents a tourist spot and is used to convert data 
// between Firestore (Map format) and the app's TouristSpot entity.
class TouristSpotModel extends TouristSpot {
  const TouristSpotModel({
    required super.id, // Unique ID of the tourist spot
    required super.name, // Name of the tourist spot
    required super.description, // Short description
    required super.imageUrls, // List of image URLs
    required super.locationLink, // Link to location (e.g., Google Maps)
  });

  // Converts Firestore data (Map) into a TouristSpotModel object.
  // This helps read and transform data fetched from Firestore.
  factory TouristSpotModel.fromMap(Map<String, dynamic> map, String id) {
    return TouristSpotModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrls: (map['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      locationLink: map['locationLink'] ?? '',
    );
  }

  // Converts the model into a Map format for saving to Firestore.
  // This is used when adding or updating data in the Firestore collection.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'locationLink': locationLink,
    };
  }
}
