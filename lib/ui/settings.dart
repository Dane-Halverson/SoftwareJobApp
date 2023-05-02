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

    late String? email = user?.email != null ? user?.email! : '';
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Account'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.email),
              title: const Text('Account Email'),
              value: Text(email!),
            ),
            SettingsTile(
              leading: const Icon(Icons.logout),
              title:  const Text('Sign out'),
              onPressed: (_) {
                context.read<AppBloc>().add(
                    const UserLoggedOutEvent()
                );
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.password),
              title: const Text('Reset Password'),
              onPressed: (_) {

              },
            ),
            SettingsTile(
              leading: const Icon(Icons.delete),
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
      ],
    );
  }
}