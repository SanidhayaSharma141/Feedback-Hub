import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/instructor.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/tools.dart';
import 'package:http/http.dart' as http;

class Course extends StrapiObject {
  String courseId;
  String? name, description;
  int? credits;
  List<Instructor>? instructors;
  Course({
    super.id,
    this.courseId = "",
    this.name,
    this.description,
    this.instructors,
    this.credits,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    courseId = data['course_id'] ?? courseId;
    name = data['Name'] ?? name;
    description = data['description'] ?? description;
    credits = data['credit'] ?? credits;
    if (data['instructors'] != null) {
      instructors = [
        for (final instructorData in data['instructors']['data'])
          Instructor()
            ..load(
              (instructorData['attributes'] as Map<String, dynamic>)
                ..addAll({"id": instructorData['id']}),
            ),
      ];
    }
  }

  Map<String, dynamic> encode() {
    return {
      'course_id': courseId,
      if (name != null) 'Name': name,
      if (description != null) 'description': description,
      if (credits != null) 'credit': credits,
      if (instructors != null) 'instructors': null,
    };
  }
}

// This function works for student
Future<List<Course>> fetchCourses() async {
  assert(settings.currentUser.studentData != null);
  final academicRecords = await fetchAcademicRecords();
  final List<Course> courses = [];
  for (final academicRecord in academicRecords) {
    if (academicRecord.course != null) courses.add(academicRecord.course!);
  }
  return courses;
}

// This function fetches all current courses of an instructor
Future<List<Course>> fetchCurrentCourses() async {
  assert(settings.currentUser.instructorData != null);
  int instructorId = settings.currentUser.instructorData!.id;
  final response = await http.get(
    Uri.parse(
      'http://$host/api/instructors/$instructorId?populate[0]=courses&populate[1]=courses.instructors',
      //?populate[0]=student&populate[1]=student.academic_records&populate[2]=student.academic_records.course&populate[3]=student.academic_records.instructor&populate[4]=student.academic_records.instructor.userdatum
    ),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  final courses =
      json.decode(response.body)['data']['attributes']['courses']['data'];
  print(courses);
  return [
    for (final courseData in courses)
      Course()
        ..load((courseData['attributes'] as Map<String, dynamic>)
          ..addAll({"id": courseData['id']}))
  ];
}

// This function fetches data of all courses present in database
Future<List<Course>> fetchAllCourses() async {
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
