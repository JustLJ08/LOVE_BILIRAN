import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    String? profileImageUrl,
  }) : super(
          id: id, // changed from uid: to id:
          name: name,
          email: email,
          role: role,
          profileImageUrl: profileImageUrl,
        );

  // Convert Firestore document to model
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    final roleString = (map['role'] as String?) ?? 'tourist';
    final role = UserRole.values.firstWhere(
      (r) => r.name == roleString,
      orElse: () => UserRole.tourist,
    );

    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: role,
      profileImageUrl: map['profileImageUrl'] as String?,
    );
  }

  // Convert model to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.name,
      'profileImageUrl': profileImageUrl,
    };
  }
}
