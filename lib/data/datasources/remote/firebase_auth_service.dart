import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/error/exceptions.dart';
import '../../models/user_model.dart';

abstract class FirebaseAuthService {
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth auth;

  FirebaseAuthServiceImpl({required this.auth});

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseAuth(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed');
    }
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseAuth(user);
    }
    return null;
  }
}