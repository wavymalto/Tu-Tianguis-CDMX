import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Esta clase de ThemeProvider es lo que utilizaremos para cambiar el estado de nuestra app
// donde guardaremos el estado del modo oscuro y normal
class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'system';

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    currentTheme = _prefs.getString('theme') ?? 'system';
    notifyListeners();
  }
}