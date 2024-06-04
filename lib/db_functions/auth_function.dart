import 'package:flutter/material.dart';
import 'package:flutter_project_final/models/usermodel.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  static const String _loggedInKey = 'isLoggedIn';

  Box<UserModel>? _userBox;

  Future<void> openBox() async {
    _userBox = await Hive.openBox<UserModel>('users');
  }

  Future<bool> registerUser(UserModel user) async {
    if (_userBox == null) {
      await openBox();
    }
    await _userBox!.put(user.id, user);
    notifyListeners();
    return true;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    if (_userBox == null) {
      await openBox();
    }
    for (var user in _userBox!.values) {
      if (user.email == email && user.password == password) {
        await setLoggedInState(true, user.id);
        return user;
      }
    }
    return null;
  }

  Future<void> setLoggedInState(bool isLoggedIn, String id) async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(_loggedInKey, isLoggedIn);
    await _pref.setString('id', id);
  }

  Future<bool> isUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_loggedInKey) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    final isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      final loggedInUserId = await getLoggedInUserId();
      return _userBox!.get(loggedInUserId);
    }
    return null;
  }

  Future<String?> getLoggedInUserId() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getString('id');
  }

  Future<bool> logOut() async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    return true;
  }
}
