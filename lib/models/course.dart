import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:http/http.dart' as http;

class Course {
  int id;
  String courseId;
  String? name, description;
  int? credits;
  String? type;
  int? semester;
  List<UserData>? instructors;
  List<UserData>? allStudents;
  List<UserData>? currentStudents;
  String? grade;
  Course({
    required this.id,
    required this.courseId,
    this.name,
    this.type = 'Departmental Core',
    this.description,
    this.instructors,
    this.allStudents,
    this.currentStudents,
    this.semester,
    this.grade,
    this.credits,
  });

  void load(Map<String, dynamic> data) {
    courseId = data['course_id'] ?? '';
    name = data['Name'];
    description = data['description'];
    credits = data['credits'];
  }

  Map<String, dynamic> encode() {
    return {
      'course_id': courseId,
      if (name != null) 'Name': name,
      if (description != null) 'description': description,
      if (credits != null) 'credit': credits,
      // if (instructors != null) 'instructors': null,
      // if (allStudents != null) 'all_students': null,
      // if (currentStudents != null) 'current_students': null,
    };
  }
}

Future<List<Course>> fetchCourses() async {
  final response = await http.get(
    Uri.parse('http://$host/api/courses'),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  final data = json.decode(response.body)['data'];
  print(data);
  final courseList = [
    for (final course in data)
      Course(id: course['id'], courseId: '')..load(course['attributes'])
  ];
  return courseList;
}
