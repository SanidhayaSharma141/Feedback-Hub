import 'package:feedback_hub/chat/widgets/call_choser.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final List<String> emails;
  const CallButton({super.key, required this.emails});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        return [
          UserData(phoneNumber: '1234567890', name: 'Alka Chaddha'),
          UserData(name: 'Ramesh Jallu', phoneNumber: '0987654321'),
        ];
      }(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          showMsg(context, snapshot.error.toString());
          return Container();
        }
        if (!snapshot.hasData) {
          return Container();
        }
        List<UserData> users = snapshot.data!;
        users.removeWhere((element) =>
            element.phoneNumber == null || element.phoneNumber!.isEmpty);
        if (users.isEmpty) {
          return Container();
        }
        return IconButton(
          icon: const Icon(Icons.call_rounded),
          onPressed: () async {
            if (users.length == 1) {
              final String url = "tel:${users[0].phoneNumber}";
              if (await askUser(context,
                      'Do you want to call ${users[0].name ?? users[0].email} (${users[0].phoneNumber})?',
                      yes: true, cancel: true) ==
                  'yes') {
                if (context.mounted) {
                  showMsg(context,
                      'Calling ${users[0].name ?? users[0].email} (${users[0].phoneNumber})');
                }
                await launchUrl(Uri.parse(url));
              }
            } else {
              await Navigator.of(context).push(
                DialogRoute(
                  context: context,
                  builder: (ctx) => CallChoser(users: users),
                ),
              );
            }
          },
        );
      },
    );
  }
}
