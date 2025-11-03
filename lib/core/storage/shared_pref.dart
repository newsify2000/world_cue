import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._();

  SharedPref._();

  factory SharedPref() => _instance;

  static SharedPreferences? sharedPref;

  Future<void> initSharedPreferences() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await sharedPref!.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await sharedPref!.setBool(key, value);
  }

  static String? getString(String key) {
    return sharedPref!.getString(key);
  }

  static bool? getBool(String key) {
    return sharedPref!.getBool(key);
  }

  static Future<void> setObject(String key, Object value) async {
    try {
      String jsonString = jsonEncode(value);
      await sharedPref!.setString(key, jsonString);
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Map<String, dynamic>? getObject(String key) {
    String? jsonString = sharedPref!.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    } else {
      return null;
    }
  }

  static Future<void> setOrAppendList(String key, List<dynamic> value) async {
    try {
      List<dynamic>? existingList = getList(key);

      if (existingList != null) {
        // Merge and remove duplicates
        final merged = {...existingList, ...value}.toList();
        value = merged;
      }

      String jsonString = jsonEncode(value);
      await sharedPref!.setString(key, jsonString);
    } catch (e) {
      debugPrint("Error in setList: $e");
    }
  }


  static List<dynamic>? getList(String key) {
    String? jsonString = sharedPref!.getString(key);
    if (jsonString != null) {
      try {
        List<dynamic> result = jsonDecode(jsonString);
        return result;
      } catch (e) {
        debugPrint("$e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<bool> delete(String key) async {
    return await sharedPref!.remove(key);
  }

  static Future<void> deleteAll() async {
    await sharedPref!.clear();
  }
}
