import 'package:firebase_auth/firebase_auth.dart';
import '../domain/auth_repository.dart';

class FirebaseAuthService implements IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<bool> get isLoggedIn =>
      _firebaseAuth.authStateChanges().map((user) => user != null);

  @override
  User? get currentUser => _firebaseAuth.currentUser;

}
