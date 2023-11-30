import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({
    super.key,
    required this.course,
    this.instructor,
  });
  final Course course;
  final UserData? instructor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name ?? "This Course is not named yet",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (instructor != null)
                Text(
                  "by ${instructor!.name ?? instructor!.email ?? 'Instructor doesn\'t have a name'}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              const Divider(),
              if (course.description != null)
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              if (course.description != null) Text(course.description!),
            ],
          ),
        ),
      ),
    );
  }
}
