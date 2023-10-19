import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class AcademicRecordScreen extends StatelessWidget {
  const AcademicRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Academic Record'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(settings.currentUser.name!),
            subtitle: Text(settings.currentUser.email!),
            trailing: Text("CGPA: 9.24"),
            leading: settings.currentUser != null &&
                    settings.currentUser!.imgUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(settings.currentUser.imgUrl!),
                    radius: 30,
                    child: settings.currentUser.imgUrl != null
                        ? null
                        : const Icon(
                            Icons.person_rounded,
                            size: 50,
                          ),
                  )
                : const Icon(Icons.person),
          ),
          Divider(
            color: Colors.grey,
          ),
          Section(
            title: 'Semester 1',
            children: [
              CourseTile(
                course: Course(
                    id: 'MA101',
                    instructor: UserData(name: 'Dr. Alka Chaddha'),
                    name: 'Mathematics 1',
                    grade: 'A'),
              ),
              CourseTile(
                  course: Course(
                      id: 'CS101',
                      instructor: UserData(name: 'Mr. John Doe'),
                      name: 'Introduction to Computer Science',
                      grade: 'A-')),
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
    return ListTile(
      title: Text(course.name ?? (course.type ?? "Course")),
      trailing: Text(course.grade ?? "B"),
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
    );
  }
}
