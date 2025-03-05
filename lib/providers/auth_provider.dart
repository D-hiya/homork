import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userType; // 'مستأجر' أو 'مؤجر'
  String? _fullName;
  String? _email;
  String? _phone;

  bool get isLoggedIn => _isLoggedIn;
  String? get userType => _userType;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phone => _phone;

  Future<bool> login(String email, String password, String userType) async {
    await Future.delayed(Duration(seconds: 1));
    _isLoggedIn = true;
    _userType = userType;
    _fullName = "محمد أحمد"; // مثال ثابت
    _email = email;
    _phone = "0123456789";
    notifyListeners();
    return _isLoggedIn;
  }

  Future<bool> register(String fullName, String email, String password,
      String phone, String userType) async {
    await Future.delayed(Duration(seconds: 1));
    _isLoggedIn = true;
    _userType = userType;
    _fullName = fullName;
    _email = email;
    _phone = phone;
    notifyListeners();
    return _isLoggedIn;
  }

  void logout() {
    _isLoggedIn = false;
    _userType = null;
    _fullName = null;
    _email = null;
    _phone = null;
    notifyListeners();
  }
}
