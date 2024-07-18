import 'package:flutter/material.dart';
import 'package:habbi_tracker/theme/dark_mode.dart';
import 'package:habbi_tracker/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData => _themeData;

  // is current theme dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    print("Chnage theme");
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
