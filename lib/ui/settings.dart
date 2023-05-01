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
  @override
  Widget build(BuildContext context) {

    late String? email = user?.email != null ? user?.email! : '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: Icon(Icons.email),
                title: Text('Account Email'),
                value: Text(email!),
              ),
              SettingsTile(
                leading: Icon(Icons.logout),
                title: Text('Sign out'),
                onPressed: (_) {
                  _onSignOut();
                },
              ),
              SettingsTile(
                leading: Icon(Icons.password),
                title: Text('Reset Password'),
                onPressed: (_) {
                  _onSignOut();
                },
              ),
              SettingsTile(
                leading: Icon(Icons.delete),
                title: Text(
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
                  leading: Icon(Icons.add_circle_outlined),
                  title: Text('Add Account'),
                  onPressed: (_) {
                    _onSignOut();
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onSignOut() {
    instance.signOut();
  }


  _onDeleteAccount() {
    user?.delete();
  }

  toSignIn() {
    throw UnimplementedError();
  }
}