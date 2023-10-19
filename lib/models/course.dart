import 'package:feedback_hub/models/user.dart';

class Course {
  String id;
  String? type;
  String? name, description;
  int? semester;
  UserData? instructor;
  String? grade;
  Course({
    required this.id,
    this.name,
    this.type = 'Departmental Core',
    this.description,
    this.instructor,
    this.semester,
    this.grade,
  });
}
