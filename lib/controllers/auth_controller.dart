import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:unihub/config.dart';

class AuthController {

  static Future logIn(String password,{
    String? email,
    String? phone
  })async{
    final res = await http.post(Uri.https(serverBaseUrl,'/verify'),body: jsonEncode({
      'email': email,
      'phone': phone,
      'password': password
    }));
    return json.decode(res.body);
  }

  static Future signUp({
    String? email,
    String? phone,
    required String name,
    required String password,
    required String profileLink
  })async{
    final res = await http.post(Uri.https(serverBaseUrl,'/signup'),body: jsonEncode({
      'email': email,
      'phone': phone,
      'password': password,
      'name': name,
      'profileLink': profileLink
    }));
    return json.decode(res.body);
  }

  static Future<bool> verify({
    required String token,
    required int userID
  })async{
    final res = await http.post(Uri.https(serverBaseUrl,'/verify'),body: jsonEncode({
      'token': token,
      'userID': userID,
    }));
   final data = json.decode(res.body);
   return data['message'] == 'success';
  }

}