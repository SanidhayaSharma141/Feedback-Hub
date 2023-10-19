import 'package:feedback_hub/main.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class MessageData {
  /// The datetime object representing the
  late String id;

  /// The markdown text
  late String txt;

  /// Sender of the message
  late String from;

  /// CreatedAt
  late DateTime createdAt;

  /// Modified At
  DateTime? modifiedAt;

  /// Set of emails who have read this msg
  Set<String> readBy = {};

  /// These indicative messages.value are used to indicate
  /// that something has happened in the chat
  /// like the inclusion of someone in the chat
  /// can only be created but not deleted
  late bool indicative;

  /// This flag represents whether the msg is deleted or not?
  DateTime? deletedAt;

  MessageData({
    required this.id,
    required this.txt,
    required this.from,
    required this.createdAt,
    this.indicative = false,
    this.modifiedAt,
    this.deletedAt,
  });

  Map<String, dynamic> encode() {
    return {
      "txt": txt,
      "from": from,
      "indicative": indicative,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "deletedAt": deletedAt == null ? null : deletedAt!.millisecondsSinceEpoch,
      if (modifiedAt != null) "modifiedAt": modifiedAt!.millisecondsSinceEpoch,
      "readBy": readBy.toList()
    };
  }

  MessageData.load(this.id, Map<String, dynamic> data) {
    txt = data["txt"];
    from = data["from"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(data["createdAt"]);
    deletedAt = data["deletedAt"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(data["deletedAt"]!);
    indicative = data["indicative"] ?? false;
    modifiedAt = data["modifiedAt"] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(data["modifiedAt"]);
    readBy = ((data['readBy'] ?? []) as List<dynamic>)
        .map((e) => e.toString())
        .toSet();
  }
}

Future<void> addMeInReadBy(ChatData chat, MessageData msg) async {
  msg.readBy.add(settings.currentUser.id.toString());
}

Future<MessageData?> fetchLastMessage(String path) async {
  return messages.value.last;
}

final ValueNotifier<List<MessageData>> messages = ValueNotifier([]);

Future<void> addMessage(ChatData chat, MessageData msg) async {
  messages.value.add(msg);
}

Future<void> deleteMessage(ChatData chat, MessageData msg) async {
  messages.value.remove(msg);
}
