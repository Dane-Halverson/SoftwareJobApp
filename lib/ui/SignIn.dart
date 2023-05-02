import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:final_project/app/bloc/app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/models.dart';
import 'themes.dart';
import 'CreateAccount.dart';

class SignIn extends StatefulWidget{
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInStatefulWidgetState();
}

class _SignInStatefulWidgetState extends State<SignIn>{

  var passwordVis = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
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
                      onPressed: (){
                        context.read<AppBloc>().add(
                          const GuestWantsToRegisterEvent()
                        );
                      },
                      child: const Text('Create Account')),]
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_sharp),
                        labelText: 'E-mail',
                      ),),
                    TextFormField(
                      obscureText: passwordVis,
                      controller: passwordController,
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
                    )
                  ],
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){},
                        child: const Text('Forgot Password?')),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 26),
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Sign in',
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  size: 24.0),]
                        ),
                        onPressed: () {
                          final email = emailController.value.text;
                          final password = passwordController.value.text;
                          context.read<AppBloc>().add(
                            UserLoggedInEvent(email: email, password: password)
                          );
                        },
                      ),
                      TextButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Continue as Guest ',
                              ),]
                        ),
                        onPressed: () {
                          //runApp(CreateAccountPage(key: super.key));
                        },
                      ),
                    ],
                  )),
              Image.asset('assets/citysky.png')
            ])));
  }
}
