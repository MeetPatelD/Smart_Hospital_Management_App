import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../services/data_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  bool login(String email, String password, String role) {
    try {
      final user = DataService.users.firstWhere(
        (u) => u.email == email && u.password == password && u.role == role,
      );
      _currentUser = user;
      DataService.currentUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool signup(String name, String email, String password) {
    bool exists = DataService.users.any((user) => user.email == email);
    if (exists) return false;

    final newUser = User(name: name, email: email, password: password, role: 'User');
    DataService.users.add(newUser);
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    DataService.currentUser = null;
    notifyListeners();
  }
}
