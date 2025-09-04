
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/app/bloc/app_state.dart';
import 'package:final_project/app/bloc/app_events.dart';

class PreferencesChip extends StatefulWidget {
  bool selected;
  String label;

  PreferencesChip({super.key, required this.selected, required this.label});

  @override
  State<PreferencesChip> createState() => PreferencesChipState();

}

class PreferencesChipState extends State<PreferencesChip> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => current is AuthorizedState && previous is AuthorizedState && previous.userData?.jobPreferences != current.userData?.jobPreferences,
      builder: (context, state) {
        bool isSelected = false;
        if (state is AuthorizedState && state.userData != null) {
          isSelected = state.userData!.hasPreference(widget.label);
        }
        return InputChip(
          padding: EdgeInsets.all(3.0),
          label: Text(widget.label),
          selected: isSelected,
          onSelected: (bool selected) {
            context.read<AppBloc>().add(UpdateUserPreferencesEvent(preference: widget.label, isSelected: selected));
          },
        );
      }
    );
  }

}

class PreferencesPage extends StatelessWidget {
  final _bioTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => current is AuthorizedState && previous is AuthorizedState && (previous.userData?.firstName != current.userData?.firstName || previous.userData?.lastName != current.userData?.lastName || previous.userData?.birthday != current.userData?.birthday || previous.userData?.bio != current.userData?.bio || previous.userData?.jobPreferences != current.userData?.jobPreferences),
      builder: (context, state) {
        if (state is! AuthorizedState || state.userData == null) {
          return const Center(child: CircularProgressIndicator()); // Or handle unauthorized state
        }
        final userData = state.userData!;
        final birthday = userData.birthday.toString().split(' ').elementAt(0);
        _bioTextController.text = userData.bio;
        return Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Your Profile', style: Theme.of(context).textTheme.displayLarge),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(userData.firstName!, style: Theme.of(context).textTheme.labelLarge),
                      Text(userData.lastName!, style: Theme.of(context).textTheme.labelLarge)
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        'Born on $birthday',
                        style: Theme.of(context).textTheme.bodyMedium
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextField(
                      controller: _bioTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    )
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ElevatedButton(
                    onPressed: () async {
                      context.read<AppBloc>().add(UpdateUserBioEvent(bio: _bioTextController.value.text));
                    },
                    child: const Text(
                      'Save'
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Select Job Tags', style: Theme.of(context).textTheme.titleLarge),
              ),
              Center(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: [
                    PreferencesChip(selected: userData.hasPreference('remote'), label: 'remote'),
                    PreferencesChip(selected: userData.hasPreference('full-time'), label: 'full-time'),
                    PreferencesChip(selected: userData.hasPreference('web-development'), label: 'web-development'),
                    PreferencesChip(selected: userData.hasPreference('mobile-development'), label: 'mobile-development'),
                    PreferencesChip(selected: userData.hasPreference('full-stack'), label: 'full-stack'),
                    PreferencesChip(selected: userData.hasPreference('front-end'), label: 'front-end'),
                    PreferencesChip(selected: userData.hasPreference('back-end'), label: 'back-end'),
                    PreferencesChip(selected: userData.hasPreference('software-development'), label: 'software-development'),
                    PreferencesChip(selected: userData.hasPreference('in-person'), label: 'in-person'),
                  ],
                )
              )
            ],
          )
        );
      }
    );
  }
}