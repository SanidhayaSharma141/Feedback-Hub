import 'dart:async';
import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/instructor.dart';
import 'package:feedback_hub/models/parent.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/student.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/tools.dart';
import 'package:http/http.dart' as http;

class UserData extends StrapiObject {
  String? name;
  String? email;
  // TODO: get role here
  String? phoneNumber;
  String? imgUrl;
  StudentData? studentData;
  Parent? parentData;
  Instructor? instructorData;

  UserData.other({
    super.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.imgUrl,
    this.studentData,
    this.parentData,
    this.instructorData,
  });

  UserData({
    super.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.imgUrl,
    this.studentData,
    this.parentData,
    this.instructorData,
  });

  Map<String, dynamic> encode() {
    return {
      // if (id != null) "id": id,
      if (email != null) "email": email,
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (imgUrl != null) "imgUrl": imgUrl,
      if (name != null) "username": name,
    };
  }

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    id = data['id'] ?? id;
    email = data['email'] ?? email;
    name = data['username'] ?? name;
    phoneNumber = data['phone_number'] ?? phoneNumber;
    imgUrl = data['imgUrl'] ?? imgUrl;
    if (data['student_data'] != null) {
      studentData = StudentData()..load(data['student_data']);
    }
    if (data['parent_data'] != null) {
      parentData = Parent()..load(data['parent_data']);
    }
    if (data['instructor_data'] != null) {
      instructorData = Instructor()..load(data['instructor_data']);
    }
  }
}

// if id parameter is skipped then it will fetch the UserData of current user
// it only fetches upto 1 depth,
// for further population of data, do individual queries to get student/instructor/parent data
Future<UserData>? fetchUserData(int? id) async {
  UserData userData = UserData();
  final response = await http.get(
    Uri.parse(
      'http://$host/api/users/${id ?? "me"}?populate[0]=student_data&populate[1]=parent_data&populate[2]=instructor_data&populate[3]=chats',
      //?populate[0]=student&populate[1]=student.academic_records&populate[2]=student.academic_records.course&populate[3]=student.academic_records.instructor&populate[4]=student.academic_records.instructor.userdatum
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
  userData.load(json.decode(response.body));
  return userData;
}
