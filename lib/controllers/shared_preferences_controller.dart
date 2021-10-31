
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController{

  static const _tokenKey = 'auth-token', _userIDKey = 'user-id';

  static late SharedPreferences _preferences;

  static late String token;

  static late int userID;

  static Future<void> init()async{

    _preferences = await SharedPreferences.getInstance();

    token = _preferences.getString(_tokenKey) ?? '';

    userID = _preferences.getInt(_userIDKey) ?? -1;

  }

  static void setToken(String token) => _preferences.setString(_tokenKey, token);

  static void setUserID(int id) => _preferences.setInt(_userIDKey, id);

}