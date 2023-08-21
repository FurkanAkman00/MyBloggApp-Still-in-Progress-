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
              toolbarHeight: 60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              systemOverlayStyle: SystemUiOverlayStyle.light,
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              foregroundColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          cardTheme: CardTheme(
              color: Colors.grey[700],
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(10))))
      : ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)))));
}
