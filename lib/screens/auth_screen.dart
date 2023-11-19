import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/screens/home_page.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/IIIT_logo.png',
            fit: BoxFit.scaleDown,
            height: 200,
            width: 200,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AuthForm(
                onSubmit: (userEmail, pwd) async {
                  final response = await http
                      .post(Uri.parse('http://$host/api/auth/local'), body: {
                    'identifier': userEmail,
                    'password': pwd,
                  });
                  print("response.body = ${response.body}");
                  print("response.headers = ${response.headers}");
                  print("response.request = ${response.request}");
                  print("response.statusCode = ${response.statusCode}");
                  final int statusCode = response.statusCode;
                  final body = json.decode(response.body);
                  if (statusCode >= 400) {
                    final err = body['error'];
                    showMsg(context, "${err['name']}: ${err['message']}");
                    return;
                  }
                  settings.jwt = body['jwt'];
                  final Map<String, dynamic> user = body['user'];
                  print(user);
                  settings.currentUser = UserData(
                    id: user['id'],
                    email: user['email'],
                    name: user['username'],
                  );
                  try {
                    final userData = await fetchUserData(null);
                    if (userData != null) {
                      settings.currentUser = userData;
                    }
                  } catch (e) {
                    if (context.mounted) {
                      showMsg(context, e.toString());
                    }
                  }
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                    showMsg(context, 'Logged in successfully');
                  }
                },
                resetPwd: (email) async {
                  throw "Not Implemented Error";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
