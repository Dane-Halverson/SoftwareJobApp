import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserData {
  String firstName;
  String lastName;
  int age;
  DateTime birthday;
  String email;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.birthday,
    required this.email
  }) {
    final now = DateTime.now();
    if (birthday.month >= now.month && birthday.day >= now.day &&
        (now.year - birthday.year) != age) {
      age++;
    }
  }

  static Future<UserData?> getUserDataFromDB() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(
          auth.currentUser?.uid);
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
        throw ErrorDescription(
            'Something went wrong when loading the user data from DB');
      }
    }
    return null;
  }
}