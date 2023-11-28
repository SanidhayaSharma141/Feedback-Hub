import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:http/http.dart' as http;

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

Future<List<UserData>> fetchChildren() async {
  final response = await http.get(
    Uri.parse('http://$host/api/users/me?populate[0]=parent_data.children'),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  final body = json.decode(response.body);
  final children = body['parent_data']['children'];
  if (children == null || children.isEmpty) return [];
  return (children as List<dynamic>).map((e) => UserData()..load(e)).toList();
}
