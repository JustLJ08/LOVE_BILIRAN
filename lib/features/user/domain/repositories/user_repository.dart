// user_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../failures/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getUserProfile(String userId);
}
