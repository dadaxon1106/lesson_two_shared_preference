import 'dart:convert';

import 'package:lesson_two_shared_preference/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static storeName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  static Future<String?> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<bool> removeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('name');
  }
  static storeUser(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user);
    await prefs.setString('user', stringUser);
  }
static Future<User?> loadUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringUser = prefs.getString('user');
  if(stringUser==null||stringUser.isEmpty) return null;
  Map<String,dynamic> map = jsonDecode(stringUser);
  return User.fromJson(map);
}
}
