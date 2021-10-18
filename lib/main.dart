import 'package:flutter/material.dart';
import 'package:unihub/views/authpage/authpage.dart';
import 'package:unihub/views/homepage/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      routes: {
        '/auth' : (context)=>const AuthPage(),
        '/home' : (context)=> const HomePage()
      },
    )
  );
}