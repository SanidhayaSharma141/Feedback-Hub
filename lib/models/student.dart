import 'package:feedback_hub/models/user.dart';

class Student extends UserData {
  DateTime? dateOfJoining;
  String? rollNumber;
  List<UserData>? parents;
  Student({
    this.dateOfJoining,
    this.rollNumber,
    this.parents,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data['userData'] ?? {});
    if (data['date_of_joining'] != null) {
      final String doj = data['date_of_joining'];
      dateOfJoining = DateTime(int.parse(doj.substring(0, 3)));
    }
    rollNumber = data['roll_number'];
    parents = data['parents'];
  }
}
