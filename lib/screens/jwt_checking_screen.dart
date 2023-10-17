import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/screens/auth_screen.dart';
import 'package:feedback_hub/screens/home_page.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JWTCheckingScreen extends StatefulWidget {
  const JWTCheckingScreen({super.key});

  @override
  State<JWTCheckingScreen> createState() => _JWTCheckingScreenState();
}

class _JWTCheckingScreenState extends State<JWTCheckingScreen> {
  Future<void> checkJWT(context) async {
    final String jwt = settings.jwt;
    final int? id = settings.currentUser.id;
    print(jwt);
    if (jwt.isNotEmpty && id != null) {
      try {
        final response = await http.get(
          Uri.parse('http://$host/api/users/me'),
          headers: {
            'Authorization': 'Bearer $jwt',
          },
        );
        final int statusCode = response.statusCode;
        final body = json.decode(response.body);
        if (statusCode >= 400) {
          final err = body['error'];
          showMsg(context, "${err['name']}: ${err['message']}");
        } else {
          final Map<String, dynamic> user = body;
          print(user);
          settings.currentUser = UserData(
            id: user['id'],
            email: user['email'],
            name: user['username'],
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          return;
        }
      } catch (e) {
        showMsg(context, e.toString());
      }
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .initializationComplete()
        .then((value) => checkJWT(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            circularProgressIndicator(),
            const Text('Logging you in'),
          ],
        ),
      ),
    );
  }
}
