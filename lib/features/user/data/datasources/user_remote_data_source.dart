import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart'; // for UserRole

abstract class UserRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String name, String email, String password, UserRole role); // changed type
  Future<UserModel> getUserProfile(String uid);
  Future<void> signOut();
}
