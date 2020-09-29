import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String loggedInKey = "ISLOGGEDIN";
  static String usernameKey = "USERNAMEKEY";
  static String emailKey = "USEREMAILKEY";

  static Future<bool> saveLoggedInKey(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsermameKey(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(usernameKey, username);
  }

  static Future<bool> saveEmailKey(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.setString(emailKey, email);
  }

  static Future<bool> getLoggedInKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(loggedInKey);
  }

  static Future<String> getUsernameKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(usernameKey);
  }

  static Future<String> getEmailKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }
}