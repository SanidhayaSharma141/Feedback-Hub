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
        future: fetchAllCourses(),
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
    return SizedBox(
      width: 150,
      child: Card(
        // child: Text(course.name ?? course.courseId),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(course.name ?? course.courseId, textAlign: TextAlign.center),
              Text("${course.courseId} - ${course.name ?? ''}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center),
              if (course.credits != null)
                Text("credits: ${course.credits}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                    textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
