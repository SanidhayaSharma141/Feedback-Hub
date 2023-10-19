import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/academic_record.dart';
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
      body: FutureBuilder(
        future: fetchAllAcademicRecords(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgressIndicator();
          }
          final data = snapshot.data;
          Map<int, List<AcademicRecord>> records = {};
          for (var record in data!) {
            if (records[record.semester] == null) {
              records[record.semester] = [];
            }
            records[record.semester]!.add(record);
          }
          return ListView(
            children: [
              ProfilePreview(
                user: settings.currentUser,
                showCallButton: false,
                showDetailsPage: false,
                showChatButton: false,
                showMailButton: false,
              ),
              ...records.entries.map(
                (entry) => Section(
                  title: "Semester ${entry.key}",
                  children: entry.value
                      .map((e) => AcademicRecordTile(record: e))
                      .toList(),
                ),
              ),
            ],
          );
        },
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
          const SizedBox(
            width: 10,
          ),
          Text(record.grade.toString()),
        ],
      ),
    );
  }
}
