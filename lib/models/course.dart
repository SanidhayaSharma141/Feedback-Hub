import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:http/http.dart' as http;

class Course extends StrapiObject {
  String courseId;
  String? name, description;
  int? credits;
  List<UserData>? instructors;
  Course({
    super.id,
    required this.courseId,
    this.name,
    this.description,
    this.instructors,
    this.credits,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    courseId = data['course_id'] ?? '';
    name = data['Name'];
    description = data['description'];
    credits = data['credit'];
    instructors = data['instructors'];
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

Future<List<Course>> fetchCourses() async {
  // if(settings.currentUser.type)
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
