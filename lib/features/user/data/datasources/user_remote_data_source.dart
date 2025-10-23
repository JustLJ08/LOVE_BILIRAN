import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart'; // for UserRole

// Abstract class defining the contract for remote user data operations
// This ensures consistency and separation between the app logic and data handling.
abstract class UserRemoteDataSource {
  // Authenticates a user with email and password, returning their user data
  Future<UserModel> signIn(String email, String password);

  // Registers a new user with name, email, password, and assigned role
  Future<UserModel> signUp(String name, String email, String password, UserRole role);

  // Retrieves the user's profile information from the database using their UID
  Future<UserModel> getUserProfile(String uid);

  // Logs out the current user from Firebase Authentication
  Future<void> signOut();
}
