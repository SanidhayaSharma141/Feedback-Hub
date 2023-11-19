import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/student.dart';
import 'package:flutter/rendering.dart';

class UserData extends StrapiObject {
  String? name;
  String? email;
  // TODO: get role here
  String? phoneNumber;
  String? imgUrl;
  StudentData? studentData;
  ParentData? parentData;

  UserData.other({
    super.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.imgUrl,
    this.studentData,
    this.parentData,
  });

  UserData({
    super.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.imgUrl,
    this.studentData,
    this.parentData,
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
    id = data['id'] ?? id;
    email = data['email'] ?? email;
    name = data['username'] ?? name;
    phoneNumber = data['phone_number'] ?? phoneNumber;
    imgUrl = data['imgUrl'] ?? imgUrl;
    studentData = data['student_data'];
    parentData = data['parent_data'];
  }
}
