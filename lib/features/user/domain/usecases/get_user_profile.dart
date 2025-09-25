// get_user_profile.dart
import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../failures/failure.dart';
import '../repositories/user_repository.dart';

class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.getUserProfile(userId);
  }
}
