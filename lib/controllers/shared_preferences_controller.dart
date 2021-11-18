
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsController{

  static const _tokenKey = 'auth-token', _userIDKey = 'user-id',
      _nameKey = 'name', _phoneOrEmailKey = 'phone-email', _profileLinkKey='profile';

  static late SharedPreferences _preferences;

  static late String token, name, phoneOrEmail, profileLink;

  static late int userID;

  static Future<void> init()async{

    _preferences = await SharedPreferences.getInstance();

    token = _preferences.getString(_tokenKey) ?? '';

    userID = _preferences.getInt(_userIDKey) ?? -1;

    phoneOrEmail = _preferences.getString(_phoneOrEmailKey) ?? '';

    name = _preferences.getString(_nameKey) ?? '';

    profileLink = _preferences.getString(_profileLinkKey) ?? 'https://picsum.photos/200';

  }

  static void setToken(String token) {
    SharedPrefsController.token = token;
    _preferences.setString(_tokenKey, token);
  }

    static void setUserID(int id) {
      userID = id;
      _preferences.setInt(_userIDKey, id);
    }

    static void setName(String name) {
      SharedPrefsController.name = name;
      _preferences.setString(_nameKey, name);
    }

    static void setProfileLink(String link) {
      profileLink = link;
      _preferences.setString(_profileLinkKey, link);
    }

    static void setPhoneEmail(String phoneOrEmail) {
      SharedPrefsController.phoneOrEmail = phoneOrEmail;
      _preferences.setString(_phoneOrEmailKey, phoneOrEmail);
    }

  }
