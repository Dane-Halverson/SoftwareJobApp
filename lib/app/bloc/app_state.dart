
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState {
  const AuthState();

  static AuthState loadAuthState() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return AuthorizedState();
    } else {
      return UnauthorizedState();
    }
  }
}

class AuthorizedState extends AuthState {
  UserData? userData;

  AuthorizedState({this.userData});
}

class UnauthorizedState extends AuthState {
  UnauthorizedState();
}

@immutable
class AuthedAsGuestState extends AuthState {
  const AuthedAsGuestState();
}