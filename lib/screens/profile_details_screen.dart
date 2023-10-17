import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserData user;
  const ProfileDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (user.email == settings.currentUser.email)
            IconButton(
              onPressed: () {
                // navigatorPush(context, EditProfile(user: user));
                showMsg(context, 'TODO: Details Screen');
              },
              icon: const Icon(
                Icons.edit_rounded,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfilePreview(
                user: user,
                showDetailsPage: false,
              ),
              const Divider(),
              Section(
                title: 'Personal Information',
                children: [
                  if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
                    KeyValueRow(
                      attribute: 'Phone Number',
                      value: user.phoneNumber!,
                    ),
                  if (user.address != null && user.address!.isNotEmpty)
                    KeyValueRow(
                      attribute: 'Address',
                      value: user.address!,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    super.key,
    required this.attribute,
    required this.value,
    this.width,
  });

  final String attribute;
  final double? width;
  final String value;

  @override
  Widget build(BuildContext context) {
    double w = width ?? MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Text(attribute),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
