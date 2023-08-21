import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/register_login/login.dart';
import 'package:myblogapp/register_login/register_view.dart';
import 'package:myblogapp/register_login/services/register_login_service.dart';
import 'package:myblogapp/register_login/start_page.dart';
import 'package:provider/provider.dart';

import '../core/auth_manager.dart';
import '../core/cache_manager.dart';
import '../homepage_view.dart';
import '../models/UserModel.dart';

abstract class RegisterLoginController<T extends StatefulWidget>
    extends State<T> with CacheManager {
  bool showError = false;
  void changeError(bool value) {
    setState(() {
      showError = value;
    });
  }

  late final RegsiterLoginService service;

  final _baseUrl = "http://10.0.2.2:5000/user/";

  @override
  void initState() {
    super.initState();
    service = RegsiterLoginService(Dio(BaseOptions(baseUrl: _baseUrl)));
  }

  Future<void> loginUser(String email, String password) async {
    final result = await service.loginUser(email, password);
    if (result != null) {
      final userResponse = await saveUser(jsonEncode(result["user"]));
      final response = await saveToken(result["token"]);
      if (response && userResponse) {
        await context.read<AuthManager>().fetchUser();
        navigateHomepage();
      } else {
        changeError(true);
      }
    }
  }

  Future<void> registerUser(User user) async {
    final response = await service.registerUser(user);
    if (response != null) {
      await saveUser(jsonEncode(response["user"]));
      await saveToken(response["token"]);
      await context.read<AuthManager>().fetchUser();
      navigateHomepage();
    } else {
      changeError(true);
    }
  }

  void navigateHomepage() {
    if (context.read<AuthManager>().isLogin) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      changeError(true);
    }
  }

  void navigateToLoginPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void navigateToRegisterPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterView()));
  }

  void navigateToStartPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const StartPage()));
  }
}
