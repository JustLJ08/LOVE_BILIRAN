import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';
import '../../domain/entities/user_entity.dart'; // for UserRole

// Implementation of the UserRemoteDataSource interface
// Handles user authentication and data retrieval from Firebase Authentication and Firestore
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth; // Used for authentication tasks (sign in, sign up, sign out)
  final FirebaseFirestore firestore; // Used for storing and retrieving user data

  // Constructor initializes both FirebaseAuth and FirebaseFirestore instances
  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  // Signs in a user with the provided email and password
  // Authenticates through FirebaseAuth and retrieves the user's data from Firestore
  @override
  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid; // Get the unique user ID from Firebase
    final userDoc = await firestore.collection('users').doc(uid).get(); // Fetch user document
    return UserModel.fromMap(userDoc.data()!, uid); // Convert Firestore data into a UserModel
  }

  // Registers a new user by creating an account in FirebaseAuth
  // Then stores user information (name, email, role) in Firestore
  @override
  Future<UserModel> signUp(
      String name, String email, String password, UserRole role) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid; // Retrieve Firebase-generated UID

    // Create a new UserModel instance
    final userModel = UserModel(
      id: uid,
      name: name,
      email: email,
      role: role, // Role is an enum value (e.g., admin, client, domain)
    );

    // Save the new user's data to Firestore
    await firestore.collection('users').doc(uid).set(userModel.toMap());

    return userModel; // Return the created user model
  }

  // Fetches a user's profile information from Firestore using their UID
  @override
  Future<UserModel> getUserProfile(String uid) async {
    final userDoc = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(userDoc.data()!, uid);
  }

  // Signs out the current user from Firebase Authentication
  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
