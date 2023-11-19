import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/screens/auth_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/loading_elevated_button.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserData user;
  const ProfileDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          LoadingElevatedButton(
            icon: const Icon(Icons.login),
            label: const Text('Sign Out'),
            onPressed: () async {
              settings.clear();
              navigatorPush(context, const AuthScreen());
            },
          ),
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
              const Text('Courses'),
              // TODO: Fetch all courses and show a horizontal line.
              // TODO: Override courses api and make it so that we get appropriate courses for each user.
              // ListView.builder(
              //   itemBuilder: (context, index) {
              //     return Container();
              //   },
              //   itemCount: ,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
