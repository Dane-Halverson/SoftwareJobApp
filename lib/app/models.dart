import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserData {
  String? firstName;
  String? lastName;
  int? age;
  DateTime? birthday;
  String? email;

  UserData({
    this.firstName,
    this.lastName,
    this.age,
    this.birthday,
    this.email
  }) {
    final now = DateTime.now();
    if (age != null && birthday != null) {
      int Age = age!;
      DateTime Birthday = birthday!;
      if (Birthday.month >= now.month && Birthday.day >= now.day && (now.year - Birthday.year) != Age) {
        Age++;
        age = Age;
      }
    }
  }

  static Future<UserData> getUserDataFromDB() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid);
      final snapshot = await userDoc.get();
      final userData = snapshot.data();
      if (userData != null) {
        return UserData(
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          age: userData['age'],
          email: userData['email'],
          birthday: DateTime.fromMillisecondsSinceEpoch(userData['birthday']),
        );
      } else {
        return UserData();
      }
    }
    throw ErrorDescription('The user should have something in the db!');
  }
}