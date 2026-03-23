import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get error => _error;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      final name = prefs.getString('userName') ?? '';
      final email = prefs.getString('userEmail') ?? '';
      final phone = prefs.getString('userPhone') ?? '';
      _user = User(
        id: '1',
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (email.isNotEmpty && password.length >= 6) {
      _user = User(
        id: '1',
        name: email.split('@')[0],
        email: email,
        phone: '+1 234 567 8900',
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', _user!.name);
      await prefs.setString('userEmail', _user!.email);
      await prefs.setString('userPhone', _user!.phone);

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Invalid email or password';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password, String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      _user = User(
        id: '1',
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', _user!.name);
      await prefs.setString('userEmail', _user!.email);
      await prefs.setString('userPhone', _user!.phone);

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Please fill all fields correctly';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> updateProfile(String name, String phone) async {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: name,
        email: _user!.email,
        phone: phone,
        avatar: _user!.avatar,
        createdAt: _user!.createdAt,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      await prefs.setString('userPhone', phone);
      notifyListeners();
    }
  }
}
