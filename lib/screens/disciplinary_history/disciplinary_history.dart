import 'dart:convert';

import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DisciplinaryScreen extends StatelessWidget {
  const DisciplinaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Your Disciplinary Record'),
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgressIndicator();
          }
          final discRecord = snapshot.data!;
          return ListView.builder(
            itemCount: discRecord.length,
            itemBuilder: (context, index) => Section(
              title: 'Level ${discRecord[index].offenceLevel} Offense',
              children: [
                Column(
                  children: [
                    ExpansionTile(
                      trailing: const SizedBox(
                        width: 1,
                        height: 1,
                      ),
                      title: Text(discRecord[index].title!),
                      // leading: const Icon(Icons.dangerous),
                      subtitle:
                          Text(discRecord[index].action ?? "No action taken"),
                      children: [
                        Text(discRecord[index].description ?? "Noting to show")
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
        future: fetchDisRecord(null),
      ),
    );
  }
}

class DisciplinaryRecord extends StrapiObject {
  String? title, action, description;
  UserData? student;
  int? offenceLevel;
  DisciplinaryRecord(
      {this.title,
      this.action,
      this.description,
      this.student,
      this.offenceLevel});

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    title = data['Title'];
    description = data['Description'];
    action = data['Action'];
    offenceLevel = data['offense'];
  }
}

Future<List<DisciplinaryRecord>> fetchDisRecord(int? id) async {
  final response = await http.get(
    Uri.parse(
      'http://$host/api/users/${id ?? "me"}?populate[0]=student_data&populate[1]=student_data.disciplinary_records',
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
  final List<dynamic> records =
      json.decode(response.body)['student_data']['disciplinary_records'];
  return records.map((e) => DisciplinaryRecord()..load(e)).toList();
}
