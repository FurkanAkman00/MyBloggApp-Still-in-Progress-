import 'package:flutter/cupertino.dart';
import 'package:myblogapp/core/cache_manager.dart';

import '../models/UserModel.dart';

class AuthManager extends CacheManager {
  BuildContext context;
  AuthManager({required this.context}) {
    fetchUser();
  }

  bool isLogin = false;
  String myToken = "";
  late User? myUser;

  Future<void> fetchUser() async {
    final token = await getToken();
    final user = await getUser();
    if (token != null) {
      isLogin = true;
      myToken = token;
      myUser = user;
    }
  }

  Future<void> deleteAll() async {
    await deleteToken();
    isLogin = false;
    myToken = "";
    myUser = null;
  }
}
