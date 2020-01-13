import 'package:flutter_assign/utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefConfig{
  static Future<bool> setIsLogin(bool isLogin) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setBool(IS_LOGIN, isLogin);
    return status;
  }
  static Future<bool> getIsLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGIN) ?? false;
  }
}