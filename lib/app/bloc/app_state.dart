
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AppState {
  const AppState();

  static AppState loadAuthState() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return AuthorizedState();
    } else {
      return UnauthorizedState();
    }
  }
}

class AuthorizedState extends AppState {
  UserData? userData;

  AuthorizedState({this.userData});
}

class UnauthorizedState extends AppState {
  UnauthorizedState();
}

@immutable
class AuthedAsGuestState extends AppState {
  const AuthedAsGuestState();
}

abstract class ThemeState {
  const ThemeState();
}

@immutable
class LightThemeState extends ThemeState {
  const LightThemeState();
}

@immutable
class DarkThemeState extends ThemeState {
  const DarkThemeState();
}