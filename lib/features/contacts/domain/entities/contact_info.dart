import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {
  final String id;
  final String name;         // e.g., "Tourism Office", "Police Station"
  final String contactNumber;
  final String category;     // e.g., "Emergency", "Tourism", "Hospital"
  final String? location;    // optional physical address or link

  const ContactInfo({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.category,
    this.location,
  });

  @override
  List<Object?> get props => [id, name, contactNumber, category, location];
}
