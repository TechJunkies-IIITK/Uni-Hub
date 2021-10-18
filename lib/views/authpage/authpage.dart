
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/views/authpage/login_widget.dart';
import 'package:unihub/views/authpage/signup_widget.dart';

class AuthPage extends StatefulWidget{

  const AuthPage({Key? key}) : super(key: key);

  @override

  _AuthPageState createState() => _AuthPageState();

}


class _AuthPageState extends State<AuthPage>{

  bool _isLogInPage =  true;

  void _togglePage() => setState(()=>_isLogInPage=!_isLogInPage);

  final ScrollController _scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        leading: _isLogInPage ? const SizedBox() : IconButton(onPressed: ()=>_togglePage(), icon: const Icon(Icons.arrow_back)),

        title: const Text('UniHub'),

      ),

      body: Center(

        child: SingleChildScrollView(

          controller: _scrollController,

          child: _isLogInPage ? LoginWidget(()=>_togglePage()) : const SignUpWidget(),

        ),

      ),

      floatingActionButton: const Text('Powered By Logo Here'),

    );

  }


}