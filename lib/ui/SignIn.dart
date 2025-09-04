import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:final_project/app/bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(children: <Widget>[
      const SizedBox(
        height: 90,
      ),
      Image.asset(
        'assets/appIcon.png',
        width: 120,
        height: 120,
      ),
      const SizedBox(
        height: 40,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('New?'),
            TextButton(
                onPressed: () {
                  //needs to actually call the page
                  BlocProvider.of<AppBloc>(context)
                      .add(const GuestWantsToRegisterEvent());
                },
                child: const Text('Create Account')),
          ]),
      SignInStateful(key: super.key),
      Image.asset('assets/citysky.png')
    ])));
  }
}

class SignInStateful extends StatefulWidget {
  const SignInStateful({super.key});

  @override
  State<SignInStateful> createState() => _SignInStatefulWidgetState();
}

class _SignInStatefulWidgetState extends State<SignInStateful> {
  var passwordVis = true;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        key: _formKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (value) {
              _email = value.toString();
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.email_sharp),
              labelText: 'E-mail',
            ),
          ),
          TextFormField(
            onChanged: (value) {
              _password = value.toString();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      //NEED TO IMPLEMENT A FORGOT PASSWORD FUNCT
                    },
                    child: const Text('Forgot Password?')),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 26),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '     Sign in',
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 24.0),
                        ]),
                    onPressed: () {
                      BlocProvider.of<AppBloc>(context).add(UserLoggedInEvent(
                          email: _email, password: _password));
                    },
                  ),
                  TextButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Continue as Guest ',
                          ),
                          Icon(Icons.person, size: 24.0)
                        ]),
                    onPressed: () {
                      BlocProvider.of<AppBloc>(context)
                          .add(const GuestLoggedInEvent());
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
