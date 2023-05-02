import 'package:firebase_auth/firebase_auth.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';


class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsStatefulWidget(key: super.key),
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

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {

    late String? email = user?.email != null ? user?.email! : '';
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Account'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.email),
              title: const Text('Account Email'),
              value: Text(email!),
            ),
            SettingsTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign out'),
              onPressed: (_) {
                _onSignOut();
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.password),
              title: const Text('Reset Password'),
              onPressed: (_) {
                _onSignOut();
              },
            ),
            SettingsTile(
              leading: const Icon(Icons.delete),
              title: const Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: (_) {
                _onDeleteAccount();
              },
            ),
            SettingsTile(
                leading: const Icon(Icons.add_circle_outlined),
                title: const Text('Add Account'),
                onPressed: (_) {
                  _onSignOut();
                }
            ),
          ],
        ),
        SettingsSection(
            title: const Text('Theme'),
            tiles: [
              SettingsTile.switchTile(
                  title: const Text('Dark Mode'),
                  leading: const Icon(Icons.nightlight_round),
                 initialValue: darkMode,
                onToggle: (bool value) {
                    setState(() {
                      darkMode = !darkMode;if (value) {
                        switchToDark();
                      }
                      else {
                        switchToLight();
                      }

                    });

                },
              )
            ])
      ],
    );
  }

  _onSignOut() {
    instance.signOut();
    toSignIn();
  }


  _onDeleteAccount() {
    user?.delete();
    toSignIn();
  }

  toSignIn() {
    //throw UnimplementedError();
  }

  void switchToDark() {}

  void switchToLight() {}


}