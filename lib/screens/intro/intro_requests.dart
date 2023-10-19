import 'package:animated_icon/animated_icon.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class IntroRequests extends StatelessWidget {
  const IntroRequests({super.key});

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
            animateIcon: AnimateIcons.confused,
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
                title: "Disciplinary history",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "The View Disciplinary History feature of FeedbackHub offers parents and guardians a powerful tool to track their child's disciplinary records at college. With just a few clicks, you can gain insight into any past disciplinary actions or incidents, helping you stay informed about your child's behavior and ensuring their success. This feature reinforces our commitment to transparency, ensuring you have all the information you need to support your child's academic journey.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
