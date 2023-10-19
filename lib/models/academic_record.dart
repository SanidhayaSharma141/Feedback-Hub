import 'package:feedback_hub/models/course.dart';
import 'package:feedback_hub/models/user.dart';

class AcademicRecord {
  Course? course;
  UserData? instructor, student;
  int semester;
  int? grade;
  AcademicRecord({
    this.course,
    this.instructor,
    this.student,
    this.semester = 0,
    this.grade,
  });
}
