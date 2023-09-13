import 'package:feedback_hub/screens/home_page.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/auth_form.dart';
import 'package:flutter/material.dart';

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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                  showMsg(context, 'Logged in successfully');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
