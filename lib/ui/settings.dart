import 'package:final_project/app/bloc/app_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';

import '../app/bloc/app_blocs.dart';


class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsStatefulWidget(key: super.key),
    );
  }
}

class SettingsStatefulWidget extends StatefulWidget {
  SettingsStatefulWidget({super.key});

  @override
  State<SettingsStatefulWidget> createState() => _SettingsStatefulWidgetState();
}

class _SettingsStatefulWidgetState extends State<SettingsStatefulWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  var instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final userData = context.read<AppBloc>().userData;
    late String? email = userData.email;
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Account'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.email),
              title: Text('Account Email', style: Theme.of(context).textTheme.labelLarge),
              value: Text(email),
            ),
            SettingsTile(
              leading: const Icon(Icons.logout),
              title:  Text('Sign out', style: Theme.of(context).textTheme.labelLarge),
              onPressed: (_) {
                context.read<AppBloc>().add(
                    const UserLoggedOutEvent()
                );
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.password),
              title: Text(
                'Reset Password',
                style: Theme.of(context).textTheme.labelLarge
              ),
              onPressed: (_) {
                // TODO implement a means of resetting password
              },
            ),
            SettingsTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error
              ),
              title: Text(
                'Delete Account',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: (_) {
                context.read<AppBloc>().add(
                  const UserDeletedAccountEvent()
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Preferences'),
          tiles: [

          ]
        ),
      ],
    );
  }
}