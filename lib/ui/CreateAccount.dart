import 'package:final_project/app/bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/bloc/app_blocs.dart';
import 'themes.dart';
import 'package:intl/intl.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccount>{

  var passwordVis = true;
  final TextEditingController _dateInput = TextEditingController();
  final _firstNameInput = TextEditingController();
  final _lastNameInput = TextEditingController();
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _reenterPasswordInput = TextEditingController();
  DateTime birthday = DateTime.now();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      context.read<AppBloc>().add(
                        const UserLoggedOutEvent()
                      );
                    },
                        child: const Text('Back to sign in')),]
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameInput,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'First Name',
                          ),),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameInput,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: _emailInput,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email_sharp),
                      labelText: 'E-mail',
                    ),),
                  TextFormField(
                    controller: _passwordInput,
                    obscureText: passwordVis,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.password_sharp),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                                passwordVis ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() { passwordVis = !passwordVis; },
                              );
                            })
                    ),
                  ),
                  TextFormField(
                    controller: _reenterPasswordInput,
                    obscureText: passwordVis,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.password_sharp),
                        labelText: 'Re-enter Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                                passwordVis ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() { passwordVis = !passwordVis; },
                              );
                            })
                    ),
                  ),
                ],
              ) ,
            ),
              const SizedBox(width: 20),
              Padding(
                  padding: const EdgeInsets.fromLTRB(100.0,25,100,30),
                  child:
                  Column(
                    children: [
                      ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Create account',
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24.0),]
                        ),
                        onPressed: () {
                          final firstName = _firstNameInput.value.text;
                          final lastName = _firstNameInput.value.text;
                          final password = _passwordInput.value.text;
                          final email = _emailInput.value.text;
                          final age = birthday.year - DateTime.now().year;
                          context.read<AppBloc>().add(
                            UserRegisteredEvent(firstName: firstName, lastName: lastName, age: age, birthday: birthday, email: email, password: password)
                          );
                        },
                      ),
                      TextButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Continue as Guest ',
                              ),
                              Icon(Icons.person,
                                  size: 24.0),]
                        ),
                        onPressed: () {
                          context.read<AppBloc>().add(
                            const GuestLoggedInEvent()
                          );
                        },
                      ),
                    ],
                  )),
              Image.asset('assets/citysky.png')
            ])));
  }

  DateTime getBirthday() {
    return birthday;
  }
}
