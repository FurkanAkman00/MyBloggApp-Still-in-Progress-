import 'package:flutter/material.dart';
import 'package:myblogapp/core/theme_manager.dart';
import 'package:myblogapp/splashpage.dart';
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
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<ThemeManager>().currentTheme,
      home: const SplashPage(),
    );
  }
}
