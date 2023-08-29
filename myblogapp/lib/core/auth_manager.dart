import 'package:flutter/cupertino.dart';
import 'package:myblogapp/core/cache_manager.dart';

class AuthManager extends CacheManager {
  BuildContext context;
  AuthManager({required this.context}) {
    fetchUser();
  }

  bool isLogin = false;
  String myToken = "";

  Future<void> fetchUser() async {
    final token = await getToken();

    if (token != null) {
      isLogin = true;
      myToken = token;
    }
  }

  Future<void> deleteAll() async {
    await deleteToken();
    isLogin = false;
    myToken = "";
  }
}
