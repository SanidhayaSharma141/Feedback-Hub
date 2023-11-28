import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/auth_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/academic_records_scroll_view.dart';
import 'package:feedback_hub/widgets/children_scroll_view.dart';
import 'package:feedback_hub/widgets/instructor_course_scroll_view.dart';
import 'package:feedback_hub/widgets/loading_elevated_button.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:feedback_hub/widgets/student_course_scroll_view.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserData user;
  const ProfileDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          LoadingElevatedButton(
            icon: const Icon(Icons.login),
            label: const Text('Sign Out'),
            onPressed: () async {
              settings.clear();
              navigatorPush(context, const AuthScreen());
            },
          ),
          if (user.email == user.email)
            IconButton(
              onPressed: () {
                // navigatorPush(context, EditProfile(user: user));
                showMsg(context, 'TODO: Details Screen');
              },
              icon: const Icon(
                Icons.edit_rounded,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfilePreview(
                user: user,
                showDetailsPage: false,
              ),
              const Divider(),
              if (user.studentData != null) const StudentCourseScrollView(),
              if (user.instructorData != null)
                const InstructorCourseScrollView(),
              if (user.studentData != null) const AcademicRecordsScrollView(),
              if (user.parentData != null) const ChildrenScrollView(),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
