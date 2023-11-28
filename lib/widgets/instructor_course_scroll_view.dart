import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/screens/courses/course_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class InstructorCourseScrollView extends StatelessWidget {
  const InstructorCourseScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Courses You Teach",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        FutureBuilder(
          future: fetchCurrentCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicator();
            }
            final courses = snapshot.data;
            if (courses == null || courses.isEmpty) {
              return const Text('You teach no courses');
            }
            return SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CourseTile(course: courses[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: courses.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
