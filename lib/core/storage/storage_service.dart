import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageKeys {}

class StorageService {
  final SharedPreferences _prefs;
  StorageService(this._prefs);

  @preResolve
  static init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return StorageService(prefs);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  get(String key) {
    return _prefs.get(key);
  }

  set(String key, dynamic value) {
    if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    } else {
      _prefs.setString(key, value.toString());
    }
  }
}
