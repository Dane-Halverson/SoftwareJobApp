
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

final _appView = BlocConsumer<AppBloc, AppState>(
    listener: (context, state) {
      // TODO add logic for showing auth errors to user here
    },
    builder: (context, state) {
      if (state is AuthorizedState) {
        if (state.userData == null) {
          return FutureBuilder<UserData>(
              future: UserData.getUserDataFromDB(),
              builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                final data = snapshot.data;
                if (!snapshot.hasData) {
                  return loader;
                }
                if (data != null) {
                  return Menu();
                }
                else {
                  return loader;
                }
              }
          );
        }
        return Menu();
      }
      if (state is UnauthorizedState) {
        return SignIn();
      }
      if (state is AuthedAsGuestState) {
        // return LoggedInView()
        return const Text('Guest view');
      }
      if (state is RegisteringState) {
        return CreateAccount();
      }
      throw ErrorDescription('A non-valid state was passed when building the app view!');
    }
);

class AppLightTheme extends StatelessWidget {
  const AppLightTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: MaterialApp(
        title: 'Final Project',
        theme: lightTheme,
        home: _appView
      )
    );
  }
}

class AppDarkTheme extends StatelessWidget {
  const AppDarkTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        create: (_) => AppBloc(),
        child: MaterialApp(
            title: 'Final Project',
            theme: lightTheme,
            home: _appView
        )
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
            return const AppLightTheme();
          }
          return const AppDarkTheme();
        }
      )
    );
  }
}