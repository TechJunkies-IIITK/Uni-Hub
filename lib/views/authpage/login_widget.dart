
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget{

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final Function goToSignUp;

  LoginWidget(this.goToSignUp,{Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(2),

      margin: const EdgeInsets.all(2),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          TextFormField(

            controller: _usernameController,

            decoration: const InputDecoration(

              hintText: 'Mobile No/Email Address',

              enabledBorder: OutlineInputBorder(

                borderSide: BorderSide( color: Colors.blueAccent, width: 2.0),

                borderRadius: BorderRadius.all(Radius.circular(5.0))

              ),

              errorBorder: OutlineInputBorder(

                borderSide: BorderSide( color: Colors.redAccent, width: 2.0),

                borderRadius: BorderRadius.all(Radius.circular(5.0))

              ),

            ),

            validator: (String? value){

              if(value == null || value.isEmpty)return "This field can't be empty";

            },

          ),

          TextFormField(

            controller: _passwordController,

            obscureText: true,

            decoration: const InputDecoration(

              hintText: 'password',

              enabledBorder: OutlineInputBorder(

                  borderSide: BorderSide( color: Colors.blueAccent, width: 2.0),

                  borderRadius: BorderRadius.all(Radius.circular(5.0))

              ),

              errorBorder: OutlineInputBorder(

                  borderSide: BorderSide( color: Colors.redAccent, width: 2.0),

                  borderRadius: BorderRadius.all(Radius.circular(5.0))

              ),

            ),

            validator: (String? value){

              if(value == null)return 'No value found';

            },

          ),

          TextButton(

              onPressed: (){

                String userName = _usernameController.text;

                String password = _passwordController.text;

                Navigator.pushNamed(context, '/home');

              },

              child: const Text('Log In')

          ),

          TextButton(

              onPressed: () => goToSignUp(),

              child: const Text('Sign Up')

          ),

        ],

      ),

    );

  }

}