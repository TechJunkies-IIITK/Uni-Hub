import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:unihub/utils/verifier.dart';
import 'package:unihub/views/snackbar.dart';

class SignUpWidget extends StatefulWidget{

  final Function onSignedUp;

  const SignUpWidget(this.onSignedUp ,{Key? key}) : super(key: key);

  @override

  // ignore: no_logic_in_create_state
  _SignUpWidgetState createState() => _SignUpWidgetState(onSignedUp);

}

class _SignUpWidgetState extends State<SignUpWidget>{

  final Function onSignedUp;

  _SignUpWidgetState(this.onSignedUp);

  int _currentStep = 0;

  bool _emailMethod = false;

  final TextEditingController _usernameController = TextEditingController(), _passwordController = TextEditingController(),
      _nameController = TextEditingController(), _profileLinkController = TextEditingController();

  TextEditingController _otpController = TextEditingController();

  void _incrementStep() => setState(()=>_currentStep++);

  void _decrementStep() => setState(()=>_currentStep=_currentStep>0?_currentStep-1:0);

  void _setMethod(bool b) => setState(()=>_emailMethod = b);

  void _onContinue(){

    switch(_currentStep){

      case 0: _incrementStep(); break;

      case 1: if(_emailMethod){

        if(Verifier.isEmail(_usernameController.text)) {

          _incrementStep();

        } else {

          showSnackBar('Invalid email', context, SnackBarType.error);

        }

      }else{

        if(Verifier.isPhone(_usernameController.text)) {

          _incrementStep();

        } else {

          showSnackBar('Invalid Phone', context, SnackBarType.error);

        }

      }
      break;

      case 2:
        if(Verifier.isOTP(_otpController.text)) {

          _incrementStep();

        } else{

          showSnackBar('Invalid OTP', context, SnackBarType.error);

        }break;

      case 3:
        if(_passwordController.text.length >= 8 && _passwordController.text.length <= 25){

          showSnackBar('Sign Up Successful', context, SnackBarType.success);

          onSignedUp();

        }else{

          showSnackBar('Length of password must be between 8 to 25', context, SnackBarType.error);

        }

    }

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

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text('Choose One Method To Sign Up'),

                  TextButton(

                    onPressed: (){_setMethod(true);_incrementStep();},

                    child: const Text('Sign Up With Email', style: TextStyle( color: Colors.white ),),

                    style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),

                    ),

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

                    suffixText: _emailMethod ? '@iiitkottayam.ac.in' : '',

                    border: InputBorder.none,

                    enabledBorder: InputBorder.none,

                    errorBorder: const OutlineInputBorder(

                      borderSide: BorderSide( color: Colors.red),

                    ),

                    disabledBorder: InputBorder.none

                  ),

                  validator: (String? value){

                    if(value == null || ( _emailMethod ? !Verifier.isEmail(value): !Verifier.isPhone(value) ) ) return 'Invalid Email';

                    return null;

                  },

                  onFieldSubmitted: (s)=>_onContinue(),

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

                child: Builder(

                  builder: (context) {

                    _otpController = TextEditingController();

                    return PinCodeTextField(

                      controller: _otpController,

                      appContext: context,

                      length: 6,

                      onChanged: (v){},

                      onSubmitted: (s)=>_onContinue(),

                      validator: (value){

                        if(value == null || !Verifier.isOTP(value)) return 'Please Enter all 6 digits';

                        return null;

                      },

                    );

                  }

                )

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

                  child: Column(
                    children: [
                      TextFormField(

                        controller: _nameController,

                        decoration: const InputDecoration(

                          hintText: 'Enter Your Name',

                          enabledBorder: InputBorder.none,

                          errorBorder: OutlineInputBorder(

                            borderSide: BorderSide( color: Colors.red),

                          ),

                          disabledBorder: InputBorder.none,

                          focusedBorder: InputBorder.none,

                        ),

                        autovalidateMode: AutovalidateMode.always,

                        validator: (String? value){

                          if(value == null || value.length >= 4) return 'Must be atleast 4 characters';

                          return null;

                        },

                      ),

                      TextFormField(

                        controller: _profileLinkController,

                        decoration: const InputDecoration(

                          hintText: 'Enter URL of your profile',

                          enabledBorder: InputBorder.none,

                          errorBorder: OutlineInputBorder(

                            borderSide: BorderSide( color: Colors.red),

                          ),

                          disabledBorder: InputBorder.none,

                          focusedBorder: InputBorder.none,

                        ),

                        autovalidateMode: AutovalidateMode.always,

                        validator: (String? value){

                          if(value == null || value.isEmpty) return 'can\'t be empty';

                          return null;

                        },

                      ),

                      TextFormField(

                        controller: _passwordController,

                        obscureText: true,

                        decoration: const InputDecoration(

                          hintText: 'Enter Password',

                          enabledBorder: InputBorder.none,

                          errorBorder: OutlineInputBorder(

                            borderSide: BorderSide( color: Colors.red),

                          ),

                          disabledBorder: InputBorder.none,

                          focusedBorder: InputBorder.none,

                        ),

                        autovalidateMode: AutovalidateMode.always,

                        validator: (String? value){

                          if(value == null || value.length > 25 || value.length < 8) return 'Password length must be between 8 to 25';

                          return null;

                        },

                        onFieldSubmitted: (s)=>_onContinue(),

                      ),
                    ],
                  )

                )

            )

        ),

      ]

    );

  }

}