import 'dart:convert';

import 'package:feedback_hub/chat/message.dart';
import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/providers/settings.dart';
import 'package:http/http.dart' as http;

class ChatData extends StrapiObject {
  List<UserData>? receivers;
  AcademicRecord? academicRecord;
  List<MessageData>? messages = [];

  ChatData({
    this.receivers,
    this.academicRecord,
    this.messages,
  });

  @override
  void load(Map<String, dynamic> data) {
    super.load(data);
    academicRecord = AcademicRecord()..load(data['academic_record']);
    receivers = [
      for (final userData in data['participants']) UserData()..load(userData)
    ];
    messages = [
      for (final msgData in data['participants']) MessageData()..load(msgData)
    ];
  }
}

Future<List<ChatData>> fetchChats(int? id) async {
  final response = await http.get(
    Uri.parse(
      'http://$host/api/users/${id ?? 'me'}?populate[0]=chats&populate[1]=chats.messages&populate[2]=chats.participants&populate[3]=chats.academic_record',
    ),
    headers: {
      'Authorization': 'Bearer ${settings.jwt}',
    },
  );
  print('response.statusCode = ${response.statusCode}');
  if (response.statusCode >= 400) {
    final err = json.decode(response.body)['error'];
    throw "${err['name']}(Code: ${err['status']}): ${err['message']}";
  }
  print('response.body = ${response.body}');
  return [
    for (final chatData
        in (json.decode(response.body)['chats'] as List<dynamic>))
      ChatData()..load(chatData)
  ];
}
