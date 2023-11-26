import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/screens/Achievements/achievement.dart';
import 'package:feedback_hub/screens/courses/course_screen.dart';
import 'package:feedback_hub/screens/disciplinary_history/disciplinary_history.dart';
import 'package:feedback_hub/screens/feedbacks/feedback.dart';
import 'package:feedback_hub/screens/main_drawer.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/dark_light_mode_button.dart';
import 'package:feedback_hub/widgets/grid_tile_logo.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:flutter/material.dart';

import 'academic_record/academic_record_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          DarkLightModeIconButton(),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 0,
            ),
            ProfilePreview(
              user: settings.currentUser,
              showCallButton: false,
              showChatButton: false,
              showMailButton: false,
            ),
            Expanded(
              child: GridView.extent(
                shrinkWrap: true,
                maxCrossAxisExtent: 320,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  GridTileLogo(
                    title: 'All Courses',
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      navigatorPush(context, const CourseScreen());
                    },
                  ),
                  GridTileLogo(
                    title: 'Academic Record',
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      navigatorPush(context, const AcademicRecordScreen());
                    },
                  ),
                  GridTileLogo(
                    title: 'Disciplinary History',
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      navigatorPush(context, const DisciplinaryScreen());
                    },
                  ),
                  GridTileLogo(
                    title: 'Your Feedbacks',
                    icon: const Icon(
                      Icons.thumbs_up_down,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      navigatorPush(context, const FeedbackScreen());
                      // showMsg(context, 'In development :-|');
                    },
                  ),
                  GridTileLogo(
                    title: 'Awards and Achievements ',
                    icon: const Icon(
                      Icons.celebration_outlined,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      navigatorPush(context, const AchievementScreen());
                      // showMsg(context, 'In development :-|');
                    },
                  ),
                  GridTileLogo(
                    title: 'Feedback Chats ',
                    icon: const Icon(
                      Icons.chat_rounded,
                      size: 50,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      showMsg(context, "TODO: ChatScreen");
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: linkText(
                context,
                title: 'Made with ❤\nSanidhaya & Shivanshu',
                url: 'https://www.github.com/shivanshukgupta/feedback_hub',
                colors: [
                  Colors.blue,
                  Colors.purple,
                  Colors.red,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
