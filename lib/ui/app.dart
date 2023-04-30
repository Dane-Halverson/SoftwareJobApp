
import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:final_project/app/bloc/app_state.dart';
import 'package:final_project/ui/Menu.dart';
import 'package:final_project/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLightTheme extends StatelessWidget {
  const AppLightTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthStatusBloc>(
      create: (_) => AuthStatusBloc(),
      child: MaterialApp(
        title: 'Final Project',
        theme: lightTheme,
        home: BlocConsumer<AuthStatusBloc, AuthState>(
          listener: (context, authState) {
            // TODO add logic for showing auth errors to user here
          },
          builder: (context, state) {
            if (state is AuthorizedState) {
              return Menu();
            }
            if (state is UnauthorizedState) {
              // return LoginView()
            }
            return const Text('Other');
          }
        )
      )
    );
  }
}