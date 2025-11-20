import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  /// Default ke system mode
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  /// Ubah mode theme
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeMode", mode.name); // Simpan sebagai string
  }

  /// Toggle dari Switch (true = dark, false = light)
  Future<void> toggleTheme(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Load theme dari local storage
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString("themeMode");

    if (saved != null) {
      switch (saved) {
        case "dark":
          _themeMode = ThemeMode.dark;
          break;
        case "light":
          _themeMode = ThemeMode.light;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }
}
