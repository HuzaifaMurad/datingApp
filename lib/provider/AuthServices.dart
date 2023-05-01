import 'package:dating_app/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';

class AuthServies with ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  String? userUid;
  AuthUser? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    userUid = user.uid;
    return AuthUser(uid: user.uid, email: user.email);
  }

  Stream<AuthUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AuthUser?> signInwithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<AuthUser?> createUserwithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userUid = credential.user!.uid;
    print(userUid);
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
