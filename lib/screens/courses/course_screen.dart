import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Courses'),
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgressIndicator();
          }
          final courses = snapshot.data!;
          return ListView(
            children: [
              ...courses.map((e) => CourseTile(course: e)),
            ],
          );
        },
        future: fetchCourses(),
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseTile extends StatelessWidget {
  Course course;
  CourseTile({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(course.name ?? course.courseId),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 0,
            spacing: 4,
            children: [
              Text(
                "${course.courseId} - ${course.name ?? ''}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
          if (course.instructors != null)
            for (final instructor in course.instructors!)
              Text(
                instructor.name ?? instructor.email!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
              ),
        ],
      ),
      children: [
        if (course.description != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(course.description!),
          ),
      ],
    );
  }
}
