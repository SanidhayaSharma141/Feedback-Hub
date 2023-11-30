import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/chat.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/parent.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/disciplinary_history/disciplinary_history.dart';
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
              label: const Text('Get UserData'),
              onPressed: () async {
                await fetchUserData(null);
              },
            ),
          if (kDebugMode)
            LoadingElevatedButton(
              icon: const Icon(Icons.abc),
              label: const Text('Get Current Courses'),
              onPressed: () async {
                if (settings.currentUser.instructorData != null) {
                  final courses = await fetchCurrentCourses();
                  print(courses);
                } else {
                  showMsg(context, "You aren't an instructor.");
                }
              },
            ),
          if (kDebugMode)
            LoadingElevatedButton(
              icon: const Icon(Icons.abc),
              label: const Text('Get Chats'),
              onPressed: () async {
                await fetchChats(null);
              },
            ),
          if (kDebugMode)
            LoadingElevatedButton(
              icon: const Icon(Icons.abc),
              label: const Text('Get Children'),
              onPressed: () async {
                print(await fetchChildren());
              },
            ),
          if (kDebugMode)
            LoadingElevatedButton(
              icon: const Icon(Icons.abc),
              label: const Text('Get Children'),
              onPressed: () async {
                await fetchDisRecord(null);
              },
            ),
        ],
      ),
    );
  }
}
