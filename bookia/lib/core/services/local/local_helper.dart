import 'dart:convert';
import 'package:bookia/features/auth/data/models/response/auth_response/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static late SharedPreferences pref;

  static String kUserData = 'user_data';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static setUserData(UserData? userData) async {
    if (userData == null) return;
    var objectJson = userData.toJson();
    var userDataString = jsonEncode(objectJson);
    await pref.setString(kUserData, userDataString);
  }

  static Future<UserData?> getUserData() async {
    var source = pref.getString(kUserData);
    if (source == null) return null;
    var jsonData = jsonDecode(source);

    return UserData.fromJson(jsonData);
  }

  static String? getString(String key) {
    return pref.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    return pref.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) {
    return pref.setBool(key, value);
  }

  static bool? getBool(String key) {
    return pref.getBool(key);
  }

  static Future<bool> setInt(String key, int value) {
    return pref.setInt(key, value);
  }

  static int? getInt(String key) {
    return pref.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) {
    return pref.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return pref.getDouble(key);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return pref.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return pref.getStringList(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }

  static Future<bool> remove(String key) {
    return pref.remove(key);
  }
}
