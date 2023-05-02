import 'package:flutter/material.dart';
import 'themes.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    TextButton(onPressed: (){},
                        child: const Text('Back to sign in')),]
              ),
              CreateAccountForm(key: super.key),
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
                          //runApp(CreateAccountPage(key: super.key));
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
                          //runApp(CreateAccountPage(key: super.key));
                        },
                      ),
                    ],
                  )),
              Image.asset('assets/citysky.png')
            ])));
  }
}

class CreateAccountForm extends StatefulWidget{
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() =>
      _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountForm>{

  var passwordVis = true;

  @override
  void initState(){
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'First Name',
                ),),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email_sharp),
              labelText: 'E-mail',
            ),),
          TextFormField(
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
    );
  }
}
