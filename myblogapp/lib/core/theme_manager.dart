import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  bool lightTheme = false;
  void changeTheme() {
    lightTheme = !lightTheme;
    notifyListeners();
  }

  ThemeData get currentTheme => lightTheme
      ? ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)))))
      : ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)))));
}
