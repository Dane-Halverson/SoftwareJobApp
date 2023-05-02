import 'package:flutter/material.dart';
import 'themes.dart';

class SignIn extends StatelessWidget {
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
                        TextButton(onPressed: (){},
                            child: const Text('Create Account')),]
                      ),
                      SignInStateful(key: super.key),
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
                        padding: const EdgeInsets.fromLTRB(100.0,25,100,30),
                        child:
                      Column(
                        children: [
                          ElevatedButton(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '     Sign in',
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

class SignInStateful extends StatefulWidget{
  const SignInStateful({super.key});

  @override
  State<SignInStateful> createState() =>
      _SignInStatefulWidgetState();
}

class _SignInStatefulWidgetState extends State<SignInStateful>{

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
         )
       ],
     ) ,
    );
  }
}
