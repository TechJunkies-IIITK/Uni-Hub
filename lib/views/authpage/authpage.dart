
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/controllers/auth_controller.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/views/authpage/login_widget.dart';
import 'package:unihub/views/authpage/signup_widget.dart';
import 'package:unihub/views/authpage/techjunkies_logo.dart';

class AuthPage extends StatefulWidget{

  const AuthPage({Key? key}) : super(key: key);

  @override

  _AuthPageState createState() => _AuthPageState();

}


class _AuthPageState extends State<AuthPage>{

  bool _isLogInPage =  true;

  void _togglePage() => setState(()=>_isLogInPage=!_isLogInPage);

  Future<void> _checkToken(BuildContext context)async{

    await SharedPrefsController.init();

    if(await AuthController.verify(token: SharedPrefsController.token, userID: SharedPrefsController.userID)){

      //user has already logged in
      Navigator.pushNamedAndRemoveUntil(context, '/home',ModalRoute.withName('/home'));

    }
  }

  final ScrollController _scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {

    _checkToken(context);

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        leading: _isLogInPage ? const SizedBox() : IconButton(onPressed: ()=>_togglePage(), icon: const Icon(Icons.arrow_back)),

        title: const Text('UniHub'),

      ),

      body: Center(

          child: _isLogInPage ? SingleChildScrollView(

              controller: _scrollController,

              child: LoginWidget(()=>_togglePage())

          ): SignUpWidget(()=>_togglePage()),


      ),

      floatingActionButton: const TechJunkiesLogo(),

    );

  }


}