import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:habbi_tracker/models/user_model.dart';

class AuthServices {
  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user from firebase user with id
  UserModel? _userWithFirebaesUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaesUserUid);
  }

  // sign in anonymous
  Future singInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userWithFirebaesUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register using email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      return _userWithFirebaesUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in using email & password
  Future signInUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      return _userWithFirebaesUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in using gmail
  Future signInWithGoogleAuth() async {
    try {
      UserCredential result =
          await _auth.signInWithProvider(GoogleAuthProvider());

      User? user = result.user;

      return _userWithFirebaesUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
