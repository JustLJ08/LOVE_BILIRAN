import '../../domain/entities/tourist_spot.dart';

class TouristSpotModel extends TouristSpot {
  const TouristSpotModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrls,
    required super.locationLink,
  });

  // Convert Firestore document to model
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'locationLink': locationLink,
    };
  }
}
