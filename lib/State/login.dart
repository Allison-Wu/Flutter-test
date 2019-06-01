import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/config/config.dart';

class LoginState extends ChangeNotifier {
  LoginState();

  String _username = '';
  String _password = '';
  String _token = '';
  String _errorMessage = '';
  bool _isFetching = false;

  String get username => _username;
  String get password => _password;
  String get token => _token;
  String get errorMessage => _errorMessage;
  bool get isFetching => _isFetching;

  void setUsername(String text) {
    _username = text;
    if (text.isEmpty) {
      _errorMessage = 'Please enter uersname';
    } else {
      _errorMessage = '';
    }
    notifyListeners();
  }

  void setPassword(String text) {
    _password = text;
    if (text.isEmpty) {
      _errorMessage = 'Please enter password';
    } else {
      _errorMessage = '';
    }
    notifyListeners();
  }

  Future<void> fetchToken() async {
    if (_username.isEmpty || _password.isEmpty) {
      _errorMessage = 'Please enter username or password!';
    } else {
      _isFetching = true;
      notifyListeners();

      var response = await http.post(
        authApi,
        body: {
          'username': _username,
          'password': _password,
        }
      );
      if (response.statusCode == 200) {
        _token = response.body;
        _errorMessage = '';
      } else {
        _errorMessage = response.body;
      }
      _isFetching = false;
    }
    notifyListeners();
  }

  void refresh() {
    _username = '';
    _password = '';
    _token = '';
    _errorMessage = '';
    _isFetching = false;
  }
}
