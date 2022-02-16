import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserProvider() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('user not logged in');
      } else {
        print('user signed in');
      }
    });
  }

  User? get getCurrentUser => _firebaseAuth.currentUser;

  void createNewUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('weak password');
      } else if (e.code == 'email-already-in-use') {
        print('email already in use');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void loginUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    print(_firebaseAuth.currentUser);
    notifyListeners();
  }

  void logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void forgotPassword(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
