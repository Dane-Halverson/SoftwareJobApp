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
  List<String> jobPreferences = <String>[];

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

  void addPreference(String preference) {
    jobPreferences.add(preference);
  }

  void removePreference(String preference) {
    int i = jobPreferences.indexOf(preference);
    jobPreferences.removeAt(i);
  }

  bool hasPreference(String preference) {
    return jobPreferences.contains(preference);
  }

  static Future<UserData> getUserDataFromDB() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid);
      final snapshot = await userDoc.get();
      final userData = snapshot.data();
      if (userData != null) {
        final data = UserData(
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          age: userData['age'],
          email: userData['email'],
          birthday: DateTime.fromMillisecondsSinceEpoch(userData['birthday']),
        );
        for (var tag in userData['jobPreferences']) {
          data.addPreference(tag);
        }
        return data;
      } else {
        return UserData();
      }
    }
    throw ErrorDescription('The user should have something in the db!');
  }
}