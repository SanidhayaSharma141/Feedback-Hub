import 'package:flutter/material.dart';

class IntroApp extends StatelessWidget {
  const IntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/IIIT_logo.png',
            color: Theme.of(context).colorScheme.primary,
            width: 250,
            height: 250,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Introducing FeedbackHub: Your Bridge to College Transparency\n\nFeedbackHub is your gateway to enhanced transparency between parents and colleges. Stay informed, engaged, and connected to your child's academic journey like never before. Join us in redefining the parent-college relationship and make education a collaborative effort.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
