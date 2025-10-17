import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';
import '../../domain/entities/user_entity.dart'; // for UserRole

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final userDoc = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(userDoc.data()!, uid);
  }

  @override
  Future<UserModel> signUp(
      String name, String email, String password, UserRole role) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    final userModel = UserModel(
      id: uid,
      name: name,
      email: email,
      role: role, // pass enum
    );

    await firestore.collection('users').doc(uid).set(userModel.toMap());

    return userModel;
  }

  @override
  Future<UserModel> getUserProfile(String uid) async {
    final userDoc = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(userDoc.data()!, uid);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}