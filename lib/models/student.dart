import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';

class StudentData extends StrapiObject {
  DateTime? dateOfJoining;
  String? rollNumber;
  UserData? parent;
  List<AcademicRecord>? academicRecords;

  StudentData({
    this.dateOfJoining,
    this.rollNumber,
    this.parent,
    this.academicRecords,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    if (data['date_of_joining'] != null) {
      final String doj = data['date_of_joining'];
      dateOfJoining = DateTime(int.parse(doj.substring(0, 3)));
    }
    rollNumber = data['roll_number'];
    parent = data['parent'];
    academicRecords = data['academic_records'];
  }
}
