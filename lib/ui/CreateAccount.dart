import 'package:final_project/app/bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/bloc/app_blocs.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
            Expanded(

              child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: ListView(children: <Widget>[
                    const SizedBox(height: 50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<AppBloc>(context).add(
                                    const UserLoggedOutEvent()
                                );
                              },
                              child: const Text('Back to sign in')),
                        ]),
                    CreateAccountForm(key: super.key),
                    const SizedBox(height: 82),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset('assets/citysky.png'),
                    )
                  ])),
            ),

          ])),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountForm> {
  var passwordVis = true;
  final TextEditingController _dateInput = TextEditingController();
  DateTime birthday = DateTime.now();
  final DateTime _currentDate = DateTime.now();

  String _pass1 = '';
  String _pass2 = '';

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  var age = 0;

  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (value){
                    _firstName = value.toString();
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'First Name',
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  onChanged: (value){
                    _lastName = value.toString();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
              )
            ],
          ),
          TextField(
            controller: _dateInput,
            //editing controller of this TextField
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_month_outlined),
              labelText: 'Enter Birthday',
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                birthday =
                    pickedDate;
                age = _currentDate.year - birthday.year;
                //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('MM/dd/yyyy').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  _dateInput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print('Date is not selected');
              }
            },
          ),
          TextFormField(
            onChanged: (value){
              _email = value.toString();
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.email_sharp),
              labelText: 'E-mail',
            ),
          ),
          TextFormField(
            onChanged: (value){
              _pass1 = value.toString();
            },
            obscureText: passwordVis,
            decoration: InputDecoration(
                icon: const Icon(Icons.password_sharp),
                labelText: 'Password',
                suffixIcon: IconButton(
                    icon: Icon(
                        passwordVis ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVis = !passwordVis;
                        },
                      );
                    })),
          ),
          TextFormField(
            onChanged: (value){
              _pass2 = value.toString();
            },
            obscureText: passwordVis,
            decoration: const InputDecoration(
                icon: Icon(Icons.password_sharp),
                labelText: 'Re-enter Password',
                ),
          ),
          const SizedBox(width: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 26),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Create account',
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 24.0),
                        ]),
                    onPressed: () {
                      if (_pass1 == _pass2) {
                        _password = _pass1;
                        BlocProvider.of<AppBloc>(context).add(
                            UserRegisteredEvent(
                                firstName: _firstName,
                                lastName: _lastName,
                                age: age,
                                birthday: birthday,
                                email: _email,
                                password: _password));
                      }
                    },
                  ),
                  TextButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Continue as Guest ',
                          ),
                          Icon(Icons.person, size: 24.0),
                        ]),
                    onPressed: () {
                      BlocProvider.of<AppBloc>(context).add(
                          const GuestLoggedInEvent()
                      );
                    },
                  ),

                ],
              )),
        ],
      ),
    );
  }

  DateTime getBirthday() {
    return birthday;
  }
}
