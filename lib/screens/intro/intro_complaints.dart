import 'package:animated_icon/animated_icon.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class IntroComplaints extends StatelessWidget {
  const IntroComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimateIcon(
            color: Theme.of(context).colorScheme.primary,
            animateIcon: AnimateIcons.chatMessage,
            iconType: IconType.continueAnimation,
            onTap: () {},
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shaderText(
                context,
                title: "Your Feedback",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Share Feedback Feature on FeedbackHub:\n\nThe Share Feedback feature on FeedbackHub is your voice in the educational process. It's a powerful tool that allows parents to provide valuable input, suggestions, and concerns directly to the college. Whether it's praising an exceptional professor, addressing a concern, or suggesting improvements, your feedback matters. With FeedbackHub, your opinions are heard, and positive changes are just a click away, fostering a dynamic and responsive educational community.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
