import 'package:feedback_hub/screens/intro/intro_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';
import 'package:feedback_hub/screens/auth_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setErrorWidget();
  runApp(const FeedbackHub());
}

class FeedbackHub extends StatelessWidget {
  const FeedbackHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          // brightness: settings.darkMode ? Brightness.dark : Brightness.light,
          seedColor: const Color.fromARGB(255, 38, 140, 235),
        ),
        textTheme: GoogleFonts.quicksandTextTheme().apply(
            // bodyColor: settings.darkMode ? Colors.white : Colors.black,
            // displayColor: settings.darkMode ? Colors.white : Colors.black,
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(done: (context) {
        navigatorPush(context, const AuthScreen());
      }),
    );
  }
}

void setErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          ':-( Something went wrong!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Text(
          '\n${details.exception}',
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Contact shivanshukgupta or sanidhayasharma141 on linkedin for support\n',
          textAlign: TextAlign.center,
        ),
      ],
    ));
  };
}
