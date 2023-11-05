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
      body: Center(
        child: FutureBuilder(
          future: fetchAcademicRecords(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              );
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
      onTap: () {
        showMsg(context, record.course!.description.toString());
      },
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
          Text(record.grade == null ? "   " : pointToGrade(record.grade!)),
        ],
      ),
    );
  }
}

String pointToGrade(double gradePoint) {
  if (gradePoint >= 9.0) {
    return 'A';
  } else if (gradePoint >= 9.0) {
    return 'A-';
  } else if (gradePoint >= 8.0) {
    return 'B';
  } else if (gradePoint >= 7.0) {
    return 'B-';
  } else if (gradePoint >= 6.0) {
    return 'C';
  } else if (gradePoint >= 5.0) {
    return 'C-';
  } else if (gradePoint >= 4.0) {
    return 'D';
  } else if (gradePoint >= 3.0) {
    return 'D-';
  }
  return 'F';
}
