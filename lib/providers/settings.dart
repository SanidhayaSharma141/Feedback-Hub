import 'dart:convert';

import 'package:feedback_hub/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String host = "192.168.143.64:1337";

class SharedPreferenceInstance {
  late SharedPreferences prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
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

  UserData _user = UserData();
  // user
  UserData get currentUser {
    _user.load(json.decode(prefs.getString('user') ?? "{}"));
    return _user;
  }

  set currentUser(UserData value) {
    _user = value;
    prefs.setString('user', json.encode(value.encode()));
  }
}
