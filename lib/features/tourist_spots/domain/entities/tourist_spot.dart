import 'package:equatable/equatable.dart';

class TouristSpot extends Equatable {
  final String id;
  final String name;
  final String description;
  final String locationLink;
  final List<String> imageUrls;

  const TouristSpot({
    required this.id,
    required this.name,
    required this.description,
    required this.locationLink,
    required this.imageUrls,
  });

  @override
  List<Object?> get props => [id, name, description, locationLink, imageUrls];
}
