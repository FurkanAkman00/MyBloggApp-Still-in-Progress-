import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myblogapp/core/theme_manager.dart';
import 'package:myblogapp/login_register.dart';
import 'package:provider/provider.dart';

import 'core/auth_manager.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthManager>(
        create: (context) => AuthManager(context: context),
      ),
      ChangeNotifierProvider<ThemeManager>(
        create: (context) => ThemeManager(),
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
      theme: context.watch<ThemeManager>().currentTheme,
      home: const LoginRegister(),
    );
  }
}

class _lightColors {
  final Color _bodyText1 = Colors.black;
}
