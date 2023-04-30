import 'package:flutter/foundation.dart' show immutable;
import 'package:final_project/app/models.dart' show UserData;

@immutable
abstract class AccountEvent {
  const AccountEvent();
}

@immutable
class UserRegisteredEvent implements AccountEvent {
  final String firstName;
  final String lastName;
  final int age;
  final DateTime birthday;
  final String email;
  final String password;

  const UserRegisteredEvent({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.birthday,
    required this.email,
    required this.password,
  });
}

@immutable
class UserLoggedInEvent implements AccountEvent {
  final String email;
  final String password;

  const UserLoggedInEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class UserLoggedOutEvent implements AccountEvent {
  const UserLoggedOutEvent();
}

@immutable
class UserDeletedAccountEvent implements AccountEvent {
  final String userId; // This is so that the user document can be deleted from Firestore

  const UserDeletedAccountEvent({
    required this.userId,
  });
}

@immutable
class GuestLoggedInEvent implements AccountEvent {
  const GuestLoggedInEvent();
}

@immutable
class GuestWantsToRegisterEvent implements AccountEvent {
  const GuestWantsToRegisterEvent();
}