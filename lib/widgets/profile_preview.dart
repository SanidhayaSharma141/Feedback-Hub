import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/profile_details_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePreview extends StatelessWidget {
  final UserData user;
  final bool showChatButton, showCallButton, showMailButton, showDetailsPage;
  const ProfilePreview({
    super.key,
    required this.user,
    this.showChatButton = true,
    this.showCallButton = true,
    this.showMailButton = true,
    this.showDetailsPage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (user.imgUrl != null) {
              navigatorPush(
                context,
                ImagePreview(
                  image: Hero(
                    tag: 'profile-image',
                    child: Image.network(user.imgUrl!),
                  ),
                ),
              );
            }
          },
          child: Hero(
            tag: 'profile-image',
            child: CircleAvatar(
              backgroundImage:
                  user.imgUrl != null ? NetworkImage(user.imgUrl!) : null,
              radius: 50,
              child: user.imgUrl != null
                  ? null
                  : const Icon(
                      Icons.person_rounded,
                      size: 50,
                    ),
            ),
          ),
        ),
        InkWell(
          onTap: showDetailsPage
              ? () => navigatorPush(context, ProfileDetailsScreen(user: user))
              : null,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shaderText(
                      context,
                      title: user.name ?? user.email!,
                      colors: [
                        Colors.deepPurpleAccent,
                        Colors.indigo,
                        Colors.blue,
                      ],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      user.email!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            if (showChatButton)
              IconButton(
                onPressed: () {
                  showMsg(context, 'Chat Screen');
                },
                icon: const Icon(Icons.chat_rounded),
              ),
            if (showCallButton)
              if (user.phoneNumber != null)
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('tel:${user.phoneNumber}'));
                  },
                  icon: const Icon(Icons.call_rounded),
                ),
            if (showMailButton)
              IconButton(
                onPressed: () {
                  launchUrl(Uri.parse('mailto:${user.email}'));
                },
                icon: const Icon(Icons.mail_rounded),
              ),
          ],
        ),
      ],
    );
  }
}
