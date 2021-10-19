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

  final TextEditingController _otpController = TextEditingController();

  void _incrementStep() => setState(()=>_currentStep++);

  void _decrementStep() => setState(()=>_currentStep=_currentStep>0?_currentStep-1:0);

  void _setMethod(bool b) => setState(()=>_emailMethod = b);

  void _onContinue(){

    if(_currentStep<3)_incrementStep();

  }

  @override

  Widget build(BuildContext context) {

    return Stepper(

      type: StepperType.horizontal,

      currentStep: _currentStep,

      onStepTapped: (int index)=> setState(() {

        _currentStep = index;

      }),

      onStepContinue: _onContinue,

      onStepCancel: _decrementStep,

      steps: [

        Step(

            title: const Text(''),

            isActive: _currentStep>=0,

            state: _currentStep==0 ? StepState.editing :  StepState.complete,

            content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Column(

                mainAxisSize: MainAxisSize.max,

                children: [

                  const Text('Choose One Method To Sign Up'),

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

            title: const Text(''),

            isActive: _currentStep>=1,

            state: _currentStep==1 ? StepState.editing :  ( _currentStep>1? StepState.complete : StepState.disabled),

            content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Chip(

                avatar: _emailMethod ? null : const Text('🇮🇳+91'),

                label: TextFormField(

                  keyboardType: _emailMethod ? TextInputType.emailAddress : TextInputType.number ,

                  controller: _usernameController,

                  decoration: InputDecoration(

                    hintText: _emailMethod ? 'Email' : 'Mobile Number',

                    border: InputBorder.none,

                    enabledBorder: InputBorder.none,

                    errorBorder: InputBorder.none,

                    disabledBorder: InputBorder.none

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

          title: const Text(''),

          isActive: _currentStep>=2,

            state: _currentStep==2 ? StepState.editing :  ( _currentStep>2? StepState.complete : StepState.disabled),

          content: Container(

              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),

              child: Center(

                child: TextFormField(

                  controller: _otpController,

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

            title: const Text(''),

            isActive: _currentStep>=3,

            state: _currentStep==3 ? StepState.editing :  ( _currentStep>3? StepState.complete : StepState.disabled),

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