import 'package:flutter/material.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _themeMode = false;

  set themeMode(bool value) {
    _themeMode = value;
    if (value) {
      _selectedTheme = _darkTheme;
    } else {
      _selectedTheme = _defaultTheme;
    }
    notifyListeners();
  }

  ThemeData _defaultTheme = ThemeData(
    primaryColor: KukbukAppTheme.blueGrey,
    colorScheme: ColorScheme.light().copyWith(
      secondary: Colors.red[900],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red[900],
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      backgroundColor: KukbukAppTheme.blueGrey,
      centerTitle: true,
    ),
  );

  ThemeData _darkTheme = ThemeData.dark().copyWith(
    //  accentColor: Colors.blue[100],
    colorScheme: ColorScheme.dark().copyWith(secondary: Colors.blue[100]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[100],
      foregroundColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
  );

  bool get themeMode => _themeMode;

  ThemeData? _selectedTheme;

  ThemeData? get selectedTheme => _selectedTheme;

  SettingsProvider() {
    getDarkModeSettings();

    // _selectedTheme = _defaultTheme;
  }

// Set app dark mode
  setDarkModeSetting(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', mode);
    print("Dark mode is : $mode");
    _themeMode = mode;
    themeMode = mode;
    notifyListeners();
  }

  // Get app dark mode and update
  Future<bool> getDarkModeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = prefs.getBool('darkMode') ?? false;
    themeMode = _themeMode;
    notifyListeners();
    return _themeMode;
  }
} // 
