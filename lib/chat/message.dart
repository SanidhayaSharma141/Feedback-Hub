import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/strapi_object.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:flutter/material.dart';

import '../models/chat.dart';

class MessageData extends StrapiObject {
  /// The markdown text
  String? txt;

  /// Sender of the message
  UserData? from;

  /// Set of emails who have read this msg
  Set<int>? readBy = {};

  /// These indicative messages.value are used to indicate
  /// that something has happened in the chat
  /// like the inclusion of someone in the chat
  /// can only be created but not deleted
  bool? indicative;

  /// This flag represents whether the msg is deleted or not?
  DateTime? deletedAt;

  MessageData({
    super.id,
    this.txt,
    this.from,
    super.createdAt,
    this.indicative = false,
    super.updatedAt,
    this.deletedAt,
  });

  Map<String, dynamic> encode() {
    return {
      "txt": txt,
      "from": from,
      "indicative": indicative,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "deletedAt": deletedAt == null ? null : deletedAt!.millisecondsSinceEpoch,
      "updatedAt": updatedAt.millisecondsSinceEpoch,
      if (readBy != null) "readBy": readBy!.toList()
    };
  }

  @override
  MessageData.load(Map<String, dynamic> data) {
    super.load(data);
    txt = data["txt"];
    if (data['from'] != null) {
      from = UserData()..load(data["from"]);
    }
    deletedAt = data["deletedAt"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(data["deletedAt"]!);
    indicative = data["indicative"] ?? false;
    readBy = ((data['readBy'] ?? []) as List<int>).map((e) => e).toSet();
  }
}

Future<void> addMeInReadBy(ChatData chat, MessageData msg) async {
  msg.readBy ??= {};
  msg.readBy!.add(settings.currentUser.id);
}

Future<MessageData?> fetchLastMessage(String path) async {
  return messages.value.last;
}

final ValueNotifier<List<MessageData>> messages = ValueNotifier([]);

Future<void> addMessage(ChatData chat, MessageData msg) async {
  final newList = messages.value;
  newList.add(msg);
  messages.value = newList;
}

Future<void> deleteMessage(ChatData chat, MessageData msg) async {
  messages.value.remove(msg);
}
