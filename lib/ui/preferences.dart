
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return InputChip(
      padding: EdgeInsets.all(3.0),
      label: Text(widget.label),
      selected: widget.selected,
      onSelected: (bool isSelected) async {
        final data = context.read<AppBloc>().userData;
        final docRef = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();
        if(isSelected) {
          data.addPreference(widget.label);
          final map = docRef.data()!;
          map['jobPreferences'] = data.jobPreferences;
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set(map);
        }
        else {
          data.removePreference(widget.label);
          final map = docRef.data()!;
          map['jobPreferences'] = data.jobPreferences;
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set(map);
        }
        setState(() {
          widget.selected = isSelected;
        });
      },
    );
  }

}

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = context.read<AppBloc>().userData;
    return Scaffold(
      body: ListView(
        children: [
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
}