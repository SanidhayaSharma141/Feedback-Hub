import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/screens/jwt_checking_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final settings = SharedPreferenceInstance();

void main() async {
  setErrorWidget();
  await settings.init();
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
      home: const JWTCheckingScreen(),
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
