import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager extends ChangeNotifier {
  bool lightTheme = true;
  void changeTheme() {
    lightTheme = !lightTheme;
    notifyListeners();
  }

  ThemeData get currentTheme => lightTheme
      ? ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              color: Colors.white,
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              foregroundColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          cardTheme: CardTheme(
              color: const Color.fromARGB(255, 102, 101, 101),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55))))
      : ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)))));
}
