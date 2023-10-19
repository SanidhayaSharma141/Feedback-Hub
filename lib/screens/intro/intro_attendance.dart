import 'package:animated_icon/animated_icon.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class IntroAttendance extends StatelessWidget {
  const IntroAttendance({super.key});

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
            animateIcon: AnimateIcons.calendarTear,
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
                title: "Academic Record",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Academic Record Feature on FeedbackHub: Keeping You Informed and Empowered\n\nThe Academic Record feature on FeedbackHub is your window into your child's educational progress. With real-time updates on grades, assignments, and attendance, you can stay informed and engaged, ensuring your child's success. Take charge of their academic journey with this powerful tool, fostering collaboration between parents and colleges for a brighter future.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
