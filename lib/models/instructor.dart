import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/strapi_object.dart';

class Instructor extends StrapiObject {
  List<AcademicRecord>? academicRecords;
  List<Course>? courses;
  Instructor({
    this.academicRecords,
    this.courses,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    academicRecords = data['academic_records'];
    courses = data['courses'];
  }
}
