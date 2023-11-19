import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/student.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/tools.dart';
import 'package:http/http.dart' as http;

class AcademicRecord extends StrapiObject {
  Course? course;
  UserData? instructor;
  StudentData? student;
  int semester;
  double? grade;
  AcademicRecord({
    super.id = 0,
    this.course,
    this.instructor,
    this.student,
    this.semester = 0,
    this.grade,
  });
}

Future<List<AcademicRecord>> fetchAcademicRecords() async {
  final response = await http.get(
    Uri.parse(
      'http://$host/api/users/me?populate[0]=student&populate[1]=student.academic_records&populate[2]=student.academic_records.course&populate[3]=student.academic_records.instructor&populate[4]=student.academic_records.instructor.userdatum',
    ),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  print('response.request = ${response.request}');
  print('response.statusCode = ${response.statusCode}');
  if (response.statusCode >= 400) {
    final err = json.decode(response.body)['error'];
    throw "${err['name']}(Code: ${err['status']}): ${err['message']}";
  }
  print('response.body = ${response.body}');
  final studentData = json.decode(response.body)['student'];
  if (studentData == null) {
    throw "Either you're not a student or you do not have permission to view this.\nIf this is a mistake contact the administrator.";
  }
  final data = studentData['academic_records'];
  print('academic_records = $data');
  if (data == null) {
    throw "No Records Found.";
  }
  final recordList = [
    for (final record in data)
      AcademicRecord(
        id: record['id'],
        course: Course(id: record['id'], courseId: '')
          ..load(record['course'] ?? {}),
        semester: record['Semester'],
        grade: (record['grade'] as int?)?.toDouble(),
        student: StudentData()..load(studentData),
        instructor: UserData()..load(record['instructor']['userdatum'] ?? {}),
      )
  ];
  return recordList;
}
