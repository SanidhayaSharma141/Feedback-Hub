import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class AcademicRecordScreen extends StatelessWidget {
  const AcademicRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Academic Record'),
      ),
      body: settings.currentUser.studentData == null
          ? const Center(child: Text('You aren\'t a student'))
          : FutureBuilder(
              future: fetchAcademicRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularProgressIndicator(),
                        const Text('Fetching your records'),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Academic Records Found.'),
                  );
                }
                final records = snapshot.data!;
                Map<int, List<AcademicRecord>> groupedRecords = {};
                for (var element in records) {
                  assert(element.course != null);
                  if (groupedRecords[element.semester] == null) {
                    groupedRecords[element.semester] = [];
                  }
                  groupedRecords[element.semester]!.add(element);
                }
                double gpa = records.fold<double>(
                    0,
                    (previousValue, element) =>
                        previousValue +
                        (element.grade ?? 0) *
                            (element.course == null
                                ? 0
                                : (element.course!.credits ?? 0)));
                int totalCredits = records.fold(
                    0,
                    (previousValue, element) =>
                        previousValue +
                        (element.course == null
                            ? 0
                            : (element.course!.credits != null &&
                                    element.grade != null
                                ? 1
                                : 0)));
                gpa /= totalCredits;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (settings.currentUser.imgUrl != null) {
                                  navigatorPush(
                                    context,
                                    ImagePreview(
                                      image: Hero(
                                        tag: 'profile-image',
                                        child: Image.network(
                                            settings.currentUser.imgUrl!),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Hero(
                                tag: 'profile-image',
                                child: CircleAvatar(
                                  backgroundImage:
                                      settings.currentUser.imgUrl != null
                                          ? NetworkImage(
                                              settings.currentUser.imgUrl!)
                                          : null,
                                  radius: 50,
                                  child: settings.currentUser.imgUrl != null
                                      ? null
                                      : const Icon(
                                          Icons.person_rounded,
                                          size: 50,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  settings.currentUser.name ??
                                      "Your name is not set yet",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  settings.currentUser.studentData!
                                          .rollNumber ??
                                      "Your roll number is not set yet",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "Current GPA: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                    ),
                                    Text(
                                      gpa.toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "Total Credits Earned: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          ),
                                    ),
                                    Text(
                                      totalCredits.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ...groupedRecords.entries.map(
                        (item) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Semester ${item.key}'),
                            ...item.value
                                .map((e) => AcademicRecordTile(record: e))
                          ],
                        ),
                      ),
                    ],
                  ),
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
      onTap: () {
        showMsg(context, record.course!.description.toString());
      },
      leading: Text(record.course!.courseId),
      title: Text(record.course!.name ?? "Unknown Course"),
      subtitle: Text(
        record.instructor == null
            ? "No Instructor"
            : record.instructor!.name ??
                record.instructor!.email ??
                "No name or email",
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
