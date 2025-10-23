import 'package:dartz/dartz.dart';
import '../../domain/failures/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

// Implementation of the UserRepository interface, handling user authentication and data operations.
// This class connects the domain layer to the data layer by calling methods from the remote data source (Firebase).
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  // Handles user login using Firebase Authentication.
  // Returns a UserEntity on success, or a Failure object on error.
  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(email, password);
      return Right(user); // Success: return user data
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Failure: return error message
    }
  }

  // Handles user registration (sign-up).
  // Creates a new user account in Firebase Auth and saves their info in Firestore.
  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String name,
    required String password,
    required UserRole role, // The user's role (admin, domain, client, etc.)
  }) async {
    try {
      final user = await remoteDataSource.signUp(name, email, password, role);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Fetches a user’s profile data from Firestore based on their unique ID (uid).
  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String uid) async {
    try {
      final user = await remoteDataSource.getUserProfile(uid);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Signs out the currently logged-in user.
  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return Right(unit); // Success: no return value needed
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
