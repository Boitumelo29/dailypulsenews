import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({required String email, required String password});
  Future<void> signOut();
  Stream<bool> get isLoggedIn;
  User? get currentUser;
}

