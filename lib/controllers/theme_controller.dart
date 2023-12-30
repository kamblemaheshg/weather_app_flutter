import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _currentTheme = ThemeData.light();
  bool _isDarkMode = false;

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    notifyListeners();
  }

}
