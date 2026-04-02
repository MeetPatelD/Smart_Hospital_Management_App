import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _currentRole = '';
  String get currentRole => _currentRole;

  void setRole(String role) {
    _currentRole = role;
    notifyListeners();
  }
}
