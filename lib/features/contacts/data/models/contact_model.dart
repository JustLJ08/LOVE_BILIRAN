import '../../domain/entities/contact_info.dart';

// The ContactModel class represents the data structure for a contact that interacts with the database.
// It extends the ContactInfo entity class from the domain layer to include data conversion methods
// (fromMap and toMap) for communication with external data sources like Firestore.
class ContactModel extends ContactInfo {
  // Constructor for ContactModel that passes all fields to the parent class (ContactInfo).
  // It uses 'super' to call the ContactInfo constructor and assign inherited properties.
  const ContactModel({
    required String id,
    required String name,
    required String contactNumber,
    required String category,
    String? email,
  }) : super(
          id: id,
          name: name,
          contactNumber: contactNumber,
          category: category,
          email: email,
        );

  // Factory constructor that creates a ContactModel from a Map (e.g., Firestore document data).
  // This is used when reading data from Firestore or other JSON-based sources.
  factory ContactModel.fromMap(Map<String, dynamic> map, String id) {
    return ContactModel(
      id: id,                                           // Document ID from Firestore
      name: map['name'] as String? ?? '',               // Contact name (default empty string if null)
      contactNumber: map['contactNumber'] as String? ?? '', // Contact number (default empty string)
      category: map['category'] as String? ?? '',       // Category (e.g., emergency, personal, etc.)
      email: map['email'] as String?,                   // Optional email field
    );
  }
  
  // Getter for 'email' (currently returns null, likely a placeholder or redundant)
  get email => null;

  // Converts the ContactModel into a Map to be stored in Firestore.
  // Each field is added to the map to match the database structure.
  Map<String, dynamic> toMap() {
    return {
      'name': name,                     // Contact's name
      'contactNumber': contactNumber,   // Contact's number
      'category': category,             // Type or group of contact
      'email': email,                   // Contact's email (optional)
    };
  }
}
