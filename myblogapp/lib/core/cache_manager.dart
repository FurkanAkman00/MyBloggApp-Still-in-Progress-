import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserModel.dart';

class CacheManager {
  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(CacheManagerKey.userToken.toString(), token);
  }

  Future<bool> saveUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(CacheManagerKey.user.toString(), user);
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myUser = prefs.getString(CacheManagerKey.user.toString());
    return User.fromJson(jsonDecode(myUser!));
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken =
        prefs.getString(CacheManagerKey.userToken.toString());
    return userToken;
  }

  Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(CacheManagerKey.userToken.toString());
  }
}

enum CacheManagerKey { userToken, user }
