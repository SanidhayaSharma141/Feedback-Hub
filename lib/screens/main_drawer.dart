import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/loading_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          if (kDebugMode)
            LoadingElevatedButton(
              icon: const Icon(Icons.abc),
              label: const Text('Get My Courses'),
              onPressed: () async {
                print("Hello");
              },
            ),
        ],
      ),
    );
  }
}
