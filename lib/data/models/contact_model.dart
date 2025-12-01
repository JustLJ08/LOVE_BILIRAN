import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    required super.id,
    required super.name,
    required super.number,
    required super.type,
  });

  factory ContactModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ContactModel(
      id: doc.id,
      name: data['name'] ?? '',
      number: data['number'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'number': number,
      'type': type,
    };
  }
}