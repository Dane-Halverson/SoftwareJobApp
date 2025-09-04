import 'package:flutter/foundation.dart' show immutable;
import 'package:final_project/app/models.dart' show UserData;

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class UserRegisteredEvent implements AppEvent {
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
class UserLoggedInEvent implements AppEvent {
  final String email;
  final String password;

  const UserLoggedInEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class NoUserEvent implements AppEvent {
  const NoUserEvent();
}

@immutable
class AppAuthChangedEvent implements AppEvent {
  const AppAuthChangedEvent();
}

@immutable
class UserLoggedOutEvent implements AppEvent {
  const UserLoggedOutEvent();
}

@immutable
class UserDeletedAccountEvent implements AppEvent {
  const UserDeletedAccountEvent();
}

@immutable
class UpdateUserPreferencesEvent implements AppEvent {
  final String preference;
  final bool isSelected;

  const UpdateUserPreferencesEvent({required this.preference, required this.isSelected});
}

@immutable
class UpdateUserBioEvent implements AppEvent {
  final String bio;

  const UpdateUserBioEvent({required this.bio});
}

@immutable
class GuestLoggedInEvent implements AppEvent {
  const GuestLoggedInEvent();
}

@immutable
class GuestWantsToRegisterEvent implements AppEvent {
  const GuestWantsToRegisterEvent();
}

@immutable
abstract class ThemeEvent {
  const ThemeEvent();
}

@immutable
class ChangedToLightThemeEvent extends ThemeEvent {
  const ChangedToLightThemeEvent();
}

@immutable
class ChangedToDarkThemeEvent extends ThemeEvent {
  const ChangedToDarkThemeEvent();
}