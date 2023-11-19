import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';

class Parent extends StrapiObject {
  List<UserData>? children;

  Parent({
    this.children,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    children = data['children'];
  }
}
