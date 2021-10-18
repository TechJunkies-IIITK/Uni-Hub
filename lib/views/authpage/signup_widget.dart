import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget{

  const SignUpWidget({Key? key}) : super(key: key);

  @override

  _SignUpWidgetState createState() => _SignUpWidgetState();

}

class _SignUpWidgetState extends State<SignUpWidget>{

  int _currentStep = 0;

  bool _emailMethod = false;

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _incrementStep() => setState(()=>_currentStep++);

  void _setMethod(bool b) => setState(()=>_emailMethod = b);

  @override

  Widget build(BuildContext context) {

    return Stepper(

      currentStep: _currentStep,

      steps: [

        Step(

            title: const Text('Choose one method to sign up'),

            isActive: _currentStep>=0,

            content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Column(

                mainAxisSize: MainAxisSize.max,

                children: [

                  TextButton(

                      onPressed: (){_setMethod(true);_incrementStep();},

                      child: const Text('Sign Up With Email')

                  ),

                  TextButton(

                      onPressed: (){_setMethod(false);_incrementStep();},

                      child: const Text('Sign Up With Mobile')

                  )

                ],

              ),

            )

        ),

        Step(

            title: _emailMethod ? const Text('Enter Your Email') : const Text('Enter Your Mobile Number'),

            isActive: _currentStep>=1,

            content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Center(

                child: TextFormField(

                  controller: _usernameController,

                  decoration: InputDecoration(

                    hintText: _emailMethod ? 'Email' : 'Mobile Number',

                  ),

                  validator: (String? value){

                    if(value == null)return 'No value found';

                  },

                  onFieldSubmitted: (String username){
                    _incrementStep();
                  },

                ),

              )

            )

        ),

        Step(

          title: const Text('Enter OTP'),

          isActive: _currentStep>=2,

          subtitle: Text("Enter the OTP sent to your ${_emailMethod ? 'Email' : 'Mobile Number'}"),

          content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Center(

                child: TextFormField(

                  decoration: const InputDecoration(

                    hintText: 'Enter OTP',

                  ),

                  validator: (String? value){

                    if(value == null)return 'No value found';

                  },

                  onFieldSubmitted: (String username){
                    _incrementStep();
                  },

                ),

              )

          )

        ),

        Step(

            title: const Text('Enter Password'),

            isActive: _currentStep>=3,

            content: Container(

                padding: const EdgeInsets.all(2),

                margin: const EdgeInsets.all(2),

                child: Center(

                  child: TextFormField(

                    controller: _passwordController,

                    obscureText: true,

                    decoration: const InputDecoration(

                      hintText: 'Enter Password',

                    ),

                    validator: (String? value){

                      if(value == null)return 'No value found';

                    },

                    onFieldSubmitted: (String username){
                      // complete sign up
                    },

                  ),

                )

            )

        )

      ]

    );

  }

}