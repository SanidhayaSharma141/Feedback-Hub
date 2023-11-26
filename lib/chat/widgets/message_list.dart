import 'package:feedback_hub/chat/message.dart';
import 'package:feedback_hub/chat/widgets/indicative_message.dart';
import 'package:feedback_hub/chat/widgets/message.dart';
import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/chat.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageList extends StatefulWidget {
  ChatData chat;
  MessageList({super.key, required this.chat});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    // TODO: add more functionality like edit a message and send messages.value in reference to other messages.value

    if (widget.chat.messages == null || messages.value.isEmpty) {
      return Center(
        child: Text(
          'Send your first message',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    widget.chat.messages = messages.value.map((e) => e).toList();
    widget.chat.messages = widget.chat.messages!.reversed.toList();
    for (final msg in widget.chat.messages!) {
      if (msg.readBy == null ||
          msg.readBy!.contains(settings.currentUser.email)) break;
      addMeInReadBy(widget.chat, msg);
    }
    return ValueListenableBuilder(
      valueListenable: messages,
      builder: (ctx, value, child) => ListView.separated(
        reverse: true,
        shrinkWrap: true,
        separatorBuilder: (ctx, index) {
          if (index == widget.chat.messages!.length - 1) return Container();
          final msg = widget.chat.messages![index];
          DateTime createdAt = msg.createdAt;
          final nextMsg = widget.chat.messages![index + 1];

          if (!_sameDay(nextMsg.createdAt, msg.createdAt)) {
            return _dateWidget(createdAt);
          }

          return SizedBox(
            height: nextMsg.from != msg.from ||
                    !_sameDay(msg.createdAt, nextMsg.createdAt)
                ? 10
                : 1,
          );
        },
        itemBuilder: (ctx, index) {
          if (index == widget.chat.messages!.length) {
            final msg = widget.chat.messages![index - 1];
            DateTime createdAt = msg.createdAt;
            return _dateWidget(createdAt);
          }
          final msg = widget.chat.messages![index];
          final nextMsg = index == widget.chat.messages!.length - 1
              ? null
              : widget.chat.messages![index + 1];
          final preMsg = index == 0 ? null : widget.chat.messages![index - 1];
          final first = nextMsg == null ||
              nextMsg.from != msg.from ||
              !_sameDay(msg.createdAt, nextMsg.createdAt);
          return Message(
            chat: widget.chat,
            msg: msg,
            last: preMsg == null ||
                preMsg.from != msg.from ||
                !_sameDay(msg.createdAt, preMsg.createdAt),
            first: first,
            msgAlignment: msg.from == settings.currentUser.email,
          );
        },
        itemCount: widget.chat.messages!.length + 1,
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) {
    return !(a.day != b.day || a.month != b.month || a.year != b.year);
  }

  Widget _dateWidget(DateTime createdAt) {
    return IndicativeMessage(txt: ddmmyyyy(createdAt));
  }
}
