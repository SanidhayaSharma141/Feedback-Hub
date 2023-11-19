import 'package:feedback_hub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String host = "localhost:1337";

ValueNotifier<bool?> darkMode = ValueNotifier(null);

class SharedPreferenceInstance {
  late SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    darkMode.value = theme;
  }

  Future<void> clear() async {
    prefs.clear();
  }

  Future<void> reload() async {
    await prefs.reload();
  }

  // JWT
  String? _jwt;

  String get jwt {
    _jwt ??= prefs.getString('jwt') ?? "";
    return _jwt!;
  }

  set jwt(String value) {
    _jwt = value;
    prefs.setString('jwt', value);
  }

  UserData currentUser = UserData();

  // dark modes
  bool? get theme {
    darkMode.value = prefs.getBool('darkMode');
    return darkMode.value;
  }

  set theme(bool? value) {
    darkMode.value = value;
    if (value != null) {
      prefs.setBool('darkMode', value);
    } else {
      prefs.remove('darkMode');
    }
  }
}
