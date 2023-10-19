import 'package:feedback_hub/chat/chat_screen.dart';
import 'package:feedback_hub/chat/message.dart';
import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class ChatData {
  String title;
  String? description;
  List<String> receivers;
  String owner;

  /// the path where chat collection is present
  String path;
  List<MessageData> messages = [];

  /// Whether the chat is locked
  bool locked = false;

  ChatData({
    required this.owner,
    required this.receivers,
    this.description,
    required this.title,
    required this.path,
    this.locked = false,
  });
}

Future<ChatData> fetchChatData(ChatData chat) async {
  return ChatData(
      owner: settings.currentUser.name!,
      receivers: ['jallu@iiitr.ac.in'],
      title: 'FeedBack Chat 1',
      path: '/chat');
}

showChat(
  BuildContext context, {
  required String id,
  required List<String> emails,
}) {
  return navigatorPush(
    context,
    ChatScreen(
      chat: ChatData(
        owner: settings.currentUser.email!,
        receivers: emails,
        title: id,
        path: 'chats/$id',
      ),
    ),
  );
}
