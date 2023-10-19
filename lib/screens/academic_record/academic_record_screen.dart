import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/profile_details_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class AcademicRecordScreen extends StatelessWidget {
  const AcademicRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Academic Record'),
      ),
      body: Column(
        children: [
          ProfilePreview(
            user: settings.currentUser,
            showCallButton: false,
            showDetailsPage: false,
            showChatButton: false,
            showMailButton: false,
          ),
          Section(
            title: 'Semester 1',
            children: [
              // TODO
            ],
          ),
        ],
      ),
    );
  }
}

class AcademicRecordTile extends StatelessWidget {
  final AcademicRecord record;
  const AcademicRecordTile({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Text(record.course!.courseId),
      title: Text(record.course!.name ?? "Unknown Course"),
      subtitle: Text(
        (record.course!.instructors ?? []).fold(
            '',
            (previousValue, element) =>
                previousValue += element.name ?? element.email!),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(record.course!.credits.toString()),
          SizedBox(
            width: 10,
          ),
          Text(record.grade.toString()),
        ],
      ),
    );
  }
}
