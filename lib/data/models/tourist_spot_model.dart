import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/tourist_spot.dart';

class TouristSpotModel extends TouristSpot {
  const TouristSpotModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.address,
  });

  factory TouristSpotModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TouristSpotModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      address: data['address'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'address': address,
    };
  }
}