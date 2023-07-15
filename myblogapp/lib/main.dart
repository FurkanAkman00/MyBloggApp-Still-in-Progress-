import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myblogapp/login_register.dart';
import 'package:provider/provider.dart';

import 'core/auth_manager.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthManager>(
        create: (context) => AuthManager(context: context),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  final _lightColor = _lightColors();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 140, 26, 160),
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)))),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(fontSize: 20, color: _lightColor._bodyText1)),
        primarySwatch: Colors.blue,
      ),
      home: const LoginRegister(),
    );
  }
}

class _lightColors {
  final Color _bodyText1 = Colors.black;
}
