import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/auth_screen.dart';
import 'package:feedback_hub/screens/home_page.dart';
import 'package:feedback_hub/screens/intro/intro_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class JWTCheckingScreen extends StatefulWidget {
  const JWTCheckingScreen({super.key});

  @override
  State<JWTCheckingScreen> createState() => _JWTCheckingScreenState();
}

class _JWTCheckingScreenState extends State<JWTCheckingScreen> {
  Future<void> checkJWT(context) async {
    final String jwt = settings.jwt;
    print("jwt=$jwt");
    if (jwt.isNotEmpty) {
      try {
        final userData = await fetchUserData(null);
        if (userData != null) {
          settings.currentUser = userData;
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
        builder: (context) => IntroScreen(
            done: (context) => navigatorPush(context, const AuthScreen())),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => checkJWT(context));
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
