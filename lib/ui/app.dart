
import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:final_project/app/bloc/app_state.dart';
import 'package:final_project/ui/Menu.dart';
import 'package:final_project/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'SignIn.dart';
import 'CreateAccount.dart';

import '../app/models.dart';

const loader = SizedBox(
    width: 60.0,
    height: 60.0,
    child: Center(
      child: CircularProgressIndicator()
  )
);

BlocConsumer<AppBloc, AppState> _getAppView() {
  return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // TODO add logic for showing auth errors to user here
      },
      builder: (context, state) {
        if (state is AuthorizedState) {
          return const Menu();
        }
        if (state is UnauthorizedState) {
          return const SignIn();
        }
        if (state is AuthedAsGuestState) {
          return const GuestMenu();
        }
        if (state is RegisteringState) {
          return CreateAccount();
        }
        throw ErrorDescription('A non-valid state was passed when building the app view!');
      }
  );
}

class AppLightTheme extends StatelessWidget {
  final _userData = UserData.getUserDataFromDB();

  AppLightTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (!snapshot.hasData) {
            return loader;
          }
          final data = snapshot.data!;
          return BlocProvider<AppBloc>(
              create: (_) => AppBloc(userData: data),
              child: MaterialApp(
                  title: 'Final Project',
                  theme: lightTheme,
                  home: _getAppView()
          ));
        }
    );
  }
}

class AppDarkTheme extends StatelessWidget {
  final _userData = UserData.getUserDataFromDB();

  AppDarkTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
        future: _userData,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (!snapshot.hasData) {
            return loader;
          }
          final data = snapshot.data!;
          return BlocProvider<AppBloc>(
              create: (_) => AppBloc(userData: data),
              child: MaterialApp(
                  title: 'Final Project',
                  theme: darkTheme,
                  home: _getAppView()
          ));
        }
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: BlocConsumer<ThemeBloc, ThemeState> (
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is LightThemeState) {
            return AppLightTheme();
          }
          return AppDarkTheme();
        }
      )
    );
  }
}