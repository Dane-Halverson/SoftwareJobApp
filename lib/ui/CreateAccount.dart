import 'package:flutter/material.dart';
import 'themes.dart';
import 'package:intl/intl.dart';


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
  final TextEditingController _dateInput = TextEditingController();
  DateTime birthday = DateTime.now();

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
          TextField(
            controller: _dateInput,
            //editing controller of this TextField
            decoration: InputDecoration(
              labelText:
              "Enter Birthday",
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now());


              if (pickedDate != null) {
                birthday = pickedDate;//pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                DateFormat('MM/dd/yyyy')
                    .format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  _dateInput.text = formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
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

  DateTime getBirthday() {
    return birthday;
  }
}
