import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _preferences;
  late bool _darkMode;

  bool get darkMode => _darkMode;

  ThemeController() {
    _darkMode = true;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? false;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
