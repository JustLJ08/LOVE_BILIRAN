import '../../domain/entities/contact_info.dart';

class ContactModel extends ContactInfo {
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

  factory ContactModel.fromMap(Map<String, dynamic> map, String id) {
    return ContactModel(
      id: id,
      name: map['name'] as String? ?? '',
      contactNumber: map['contactNumber'] as String? ?? '',
      category: map['category'] as String? ?? '',
      email: map['email'] as String?,
    );
  }
  
  get email => null;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contactNumber': contactNumber,
      'category': category,
      'email': email,
    };
  }
}