import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_events.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.loadAuthState()) {
    // since the user data would be null here, we can use a future builder to build the pages requiring the user data class if the Authorized state is detected with null data
    on<UserRegisteredEvent>((UserRegisteredEvent event, Emitter<AppState> emit) async {
      final auth = FirebaseAuth.instance;
      try {
        final credentials = await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        final id = credentials.user?.uid;
        if (id != null) {
          await FirebaseFirestore.instance.collection('users').doc(id).set({
            'firstName': event.firstName,
            'lastName': event.lastName,
            'age': event.age,
            'birthday': event.birthday.millisecondsSinceEpoch,
            'email': event.email,
          });
          emit(
            AuthorizedState(
              userData: UserData(
                firstName: event.firstName,
                lastName: event.lastName,
                age: event.age,
                birthday: event.birthday,
                email: event.email
              )
            )
          );
        }
      } on FirebaseAuthException catch(err) {
        // TODO handle registration error
      }
    });
    on<UserLoggedInEvent>((UserLoggedInEvent event, Emitter<AppState> emit) async {
      final auth = FirebaseAuth.instance;
      try {
        await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
        final userData = await UserData.getUserDataFromDB();

        emit(AuthorizedState(userData: userData));
      } on FirebaseAuthException catch(err) {
        // TODO handle sign in errors
      }
    });
    on<UserLoggedOutEvent>((UserLoggedOutEvent event, Emitter<AppState> emit) async {
      await FirebaseAuth.instance.signOut();

      emit(UnauthorizedState());
    });
    on<UserDeletedAccountEvent>((UserDeletedAccountEvent event, Emitter<AppState> emit) async {
      final auth = FirebaseAuth.instance;
      final currUser = auth.currentUser;
      if (currUser != null) {
        try {
          await FirebaseFirestore.instance.collection('users').doc(currUser.uid).delete();
          await currUser.delete();

          emit(UnauthorizedState());
        } on FirebaseAuthException catch(err) {
          // TODO delete may throw an error requiring the user to auth again, so handle this error
        }
      }
    });
    on<GuestLoggedInEvent>((GuestLoggedInEvent event, Emitter<AppState> emit) async {
      final auth = FirebaseAuth.instance;
      try {
        await auth.signInAnonymously();

        emit(const AuthedAsGuestState());
      } on FirebaseAuthException catch(err) {
        // TODO handle the sign in error
      }
    });
  }
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const LightThemeState()) {
    on<ChangedToLightThemeEvent>((event, emit) {
      emit(const LightThemeState());
    });
    on<ChangedToDarkThemeEvent>((event, emit) {
      emit(const DarkThemeState());
    });
  }
}