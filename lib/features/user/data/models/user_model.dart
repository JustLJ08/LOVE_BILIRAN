import '../../domain/entities/user_entity.dart';

// UserModel represents the structure of user data as stored in Firestore.
// It extends UserEntity (the domain-level class) to maintain a clean architecture separation.
class UserModel extends UserEntity {
  const UserModel({
    required String id, // Unique user ID from Firebase Authentication
    required String name, // User's full name
    required String email, // User's email address
    required UserRole role, // User's assigned role (e.g., admin, client, tourist)
    String? profileImageUrl, // Optional profile picture URL
  }) : super(
          id: id, // Initialize the inherited UserEntity class fields
          name: name,
          email: email,
          role: role,
          profileImageUrl: profileImageUrl,
        );

  // Factory constructor to convert Firestore document data into a UserModel object
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    // Convert the 'role' string from Firestore into a UserRole enum value
    final roleString = (map['role'] as String?) ?? 'tourist';
    final role = UserRole.values.firstWhere(
      (r) => r.name == roleString,
      orElse: () => UserRole.tourist, // Default role if not found
    );

    return UserModel(
      id: id,
      name: map['name'] ?? '', // Default to empty string if null
      email: map['email'] ?? '',
      role: role,
      profileImageUrl: map['profileImageUrl'] as String?, // Optional field
    );
  }

  // Converts the UserModel object into a Map format for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.name, // Save enum as string (e.g., "admin", "tourist")
      'profileImageUrl': profileImageUrl,
    };
  }
}
