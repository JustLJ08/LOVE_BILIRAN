// user_entity.dart
import 'package:equatable/equatable.dart';

enum UserRole { tourist, admin }

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  @override
  List<Object?> get props => [id, email, name, role];
}
