import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/student.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:http/http.dart' as http;

class AcademicRecord {
  int id;
  Course? course;
  UserData? instructor;
  Student? student;
  int semester;
  int? grade;
  AcademicRecord({
    this.id = 0,
    this.course,
    this.instructor,
    this.student,
    this.semester = 0,
    this.grade,
  });
}

Future<List<AcademicRecord>> fetchAllAcademicRecords() async {
  final response = await http.get(
    Uri.parse('http://$host/api/academic-records'),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  final data = json.decode(response.body)['data'];
  print(data);
  final recordList = [
    for (final record in data)
      AcademicRecord(
        id: record['id'],
        course: Course(id: record['id'], courseId: '')
          ..load(record['attributes']['course'] ?? {}),
        semester: record['attributes']['Semester'],
        grade: record['attributes']['grade'],
        student: Student()..load(record['attributes']['student'] ?? {}),
      )
  ];
  return recordList;
}
