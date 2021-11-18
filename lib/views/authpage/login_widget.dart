
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/controllers/auth_controller.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/utils/verifier.dart';
import 'package:unihub/views/snackbar.dart';

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

              onPressed: ()async{

                String userName = _usernameController.text;

                String password = _passwordController.text;

                dynamic data;

                if(Verifier.isPhone(userName)) {

                  data = await AuthController.logIn(password,phone: userName);

                }else if(Verifier.isEmail(userName)) {

                  data = await AuthController.logIn(

                      password, email: userName.endsWith("ac.in") ? userName: '$userName@iiitkottayam.ac.in'

                  );

                }

                if(data !=null && data['message'] == 'success') {

                  SharedPrefsController.setToken(data['token']);

                  SharedPrefsController.setUserID(data['userID']);

                  SharedPrefsController.setName(data['name']);

                  SharedPrefsController.setPhoneEmail(data['phoneOrEmail']);

                  SharedPrefsController.setProfileLink(data['profileLink']);

                  showSnackBar("Login Success", context, SnackBarType.success);

                  Navigator.pushNamedAndRemoveUntil(context, '/home',ModalRoute.withName('/home'));

                }

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