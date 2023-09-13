import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Courses'),
      ),
      body: ListView(
        children: [
          Section(
            title: 'Semester 1',
            children: [
              CourseTile(
                course: Course(
                  id: 'MA101',
                  instructor: UserData(name: 'Dr. Alka Chaddha'),
                  name: 'Mathematics 1',
                  description:
                      'Mathematics is a fundamental subject that is essential for many college majors, including engineering, computer science, economics, and statistics. The specific math courses that college students take will vary depending on their major and career goals. However, some of the most common math courses for college students include:\nCalculus\nLinear algebra\nProbability and statistics\nDifferential equations\nNumerical methods',
                ),
              ),
              CourseTile(
                  course: Course(
                id: 'CS101',
                instructor: UserData(name: 'Mr. John Doe'),
                name: 'Introduction to Computer Science',
                description:
                    'Computer science is the study of computers and computational systems. It includes the study of algorithms, programming languages, data structures, operating systems, and artificial intelligence.',
              )),
              CourseTile(
                  course: Course(
                id: 'ENG101',
                instructor: UserData(name: 'Dr. Jane Smith'),
                name: 'Introduction to Engineering',
                description:
                    'Engineering is the application of scientific principles to solve practical problems. It includes the study of mechanics, thermodynamics, electrical engineering, and civil engineering.',
              )),
              CourseTile(
                  course: Course(
                id: 'PHY101',
                instructor: UserData(name: 'Professor William Jones'),
                name: 'Introduction to Physics',
                description:
                    'Physics is the study of matter and energy. It includes the study of mechanics, thermodynamics, electromagnetism, and quantum mechanics.',
              )),
              CourseTile(
                  course: Course(
                id: 'STA101',
                instructor: UserData(name: 'Ms. Mary Brown'),
                name: 'Introduction to Statistics',
                description:
                    'Statistics is the study of data collection, analysis, interpretation, and presentation. It is used in many different fields, including business, economics, and healthcare.',
              )),
              CourseTile(
                course: Course(
                  id: 'ECO101',
                  instructor: UserData(name: 'Dr. David Green'),
                  name: 'Introduction to Economics',
                  description:
                      'Economics is the study of how people make choices under scarcity. It includes the study of microeconomics, macroeconomics, and international economics.',
                ),
              ),
            ],
          ),
          Section(title: 'Semester 2', children: [
            CourseTile(
                course: Course(
                    id: 'CSE101',
                    instructor: UserData(name: 'Dr. Susan White'),
                    name: 'Data Structures and Algorithms',
                    description:
                        'This course covers the fundamental data structures and algorithms used in computer science. Topics include arrays, linked lists, stacks, queues, trees, graphs, and sorting and searching algorithms.')),
            CourseTile(
                course: Course(
                    id: 'CSE201',
                    instructor: UserData(name: 'Professor Michael Black'),
                    name: 'Programming Languages',
                    description:
                        'This course introduces the different programming languages used in computer science. Topics include procedural programming, object-oriented programming, functional programming, and logic programming.')),
            CourseTile(
                course: Course(
                    id: 'CSE301',
                    instructor: UserData(name: 'Ms. Sarah Green'),
                    name: 'Operating Systems',
                    description:
                        'This course covers the fundamental concepts of operating systems. Topics include process management, memory management, file systems, and device drivers.')),
            CourseTile(
                course: Course(
                    id: 'CSE401',
                    instructor: UserData(name: 'Dr. John Smith'),
                    name: 'Computer Networks',
                    description:
                        'This course covers the fundamental concepts of computer networks. Topics include OSI model, TCP/IP model, routing, and switching.')),
            CourseTile(
                course: Course(
                    id: 'CSE501',
                    instructor: UserData(name: 'Professor Jane Doe'),
                    name: 'Artificial Intelligence',
                    description:
                        'This course covers the fundamental concepts of artificial intelligence. Topics include search, reasoning, planning, machine learning, and natural language processing.'))
          ])
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  Course course;
  CourseTile({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(course.name ?? (course.type ?? "Course")),
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
                "${course.id} - ${course.type ?? ''}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              if (course.semester != null)
                Text(
                  course.semester!.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
            ],
          ),
          if (course.instructor != null)
            Text(
              course.instructor!.name ?? course.instructor!.email!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
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
