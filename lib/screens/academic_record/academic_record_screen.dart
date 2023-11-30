import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/parent.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/screens/courses/course_details_screen.dart';
import 'package:feedback_hub/screens/profile_screens/profile_details_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                int totalCredits = 0;
                double gpa = 0;
                Map<int, List<AcademicRecord>> groupedRecords = {};
                for (var element in records) {
                  assert(element.course != null);
                  if (groupedRecords[element.semester] == null) {
                    groupedRecords[element.semester] = [];
                  }
                  groupedRecords[element.semester]!.add(element);
                  if (element.course != null && element.grade != null) {
                    totalCredits += element.course!.credits ?? 0;
                    gpa += element.grade! * (element.course!.credits ?? 0);
                  }
                }
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
                      const Divider(),
                      ...groupedRecords.entries.map(
                        (item) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Grade',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                  ),
                                  Text(
                                    'Semester ${item.key}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                  ),
                                  Text(
                                    'Credits',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                  ),
                                ],
                              ),
                            ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpansionTile(
          leading: Text(
            record.grade == null ? "   " : pointToGrade(record.grade!),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
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
              Text(
                record.course!.credits.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  if (record.course != null)
                    IconWithLabel(
                      iconBttn: IconButton(
                          onPressed: () {
                            navigatorPush(
                              context,
                              CourseDetailScreen(
                                course: record.course!,
                                instructor: record.instructor,
                              ),
                            );
                          },
                          icon: const Icon(Icons.book_rounded)),
                      label: "Course",
                    ),
                  if (record.instructor != null)
                    IconWithLabel(
                      iconBttn: IconButton(
                        onPressed: () {
                          navigatorPush(
                            context,
                            ProfileDetailsScreen(user: record.instructor!),
                          );
                        },
                        icon: const Icon(Icons.person_rounded),
                      ),
                      label: "Instructor",
                    ),
                  IconWithLabel(
                    iconBttn: IconButton(
                      onPressed: () async {
                        if (record.feedback != null) {
                          showMsg(context, 'Feedback can only be given once.');
                          return;
                        }
                        final student = record.student!;
                        final instructor = record.instructor!;
                        final parent = await fetchParent(record.student!.id);
                        final resp = await promptUser(context,
                            question: "Your Feedback",
                            description: "Your view on this course?");
                        try {
                          final response = await http.post(
                              Uri.parse('http://$host/api/chats'),
                              headers: {
                                'Authorization': 'Bearer ${settings.jwt}',
                                'Content-Type': 'application/json',
                              },
                              body: json.encode({
                                'data': {
                                  'academic_record': record.id,
                                  'message': resp,
                                  'participants': [
                                    settings.currentUser.id,
                                    parent.id,
                                    instructor.id,
                                  ],
                                }
                              }));
                          if (context.mounted) {
                            if (response.statusCode == 200) {
                              showMsg(context, 'Feedback Sent');
                            } else {
                              showMsg(context,
                                  'Feedback Not Sent\n${response.body}');
                            }
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      icon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                      ),
                    ),
                    label: "Feedback",
                  ),
                ],
              ),
            ),
            if (record.feedback != null) const Divider(),
            if (record.feedback != null)
              Text(
                'Your Feedback:',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
            if (record.feedback != null)
              Text(record.feedback!.message ?? "No Message Here Yet"),
          ],
        ),
      ],
    );
  }
}

class IconWithLabel extends StatelessWidget {
  final IconButton iconBttn;
  final String label;
  const IconWithLabel({
    super.key,
    required this.iconBttn,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconBttn,
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
