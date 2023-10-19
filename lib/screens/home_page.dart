import 'package:feedback_hub/main.dart';
import 'package:feedback_hub/screens/courses/course_screen.dart';
import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/grid_tile_logo.dart';
import 'package:feedback_hub/widgets/profile_preview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
            ProfilePreview(
              user: settings.currentUser,
              showCallButton: false,
              showChatButton: false,
              showMailButton: false,
            ),
            GridView.extent(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              maxCrossAxisExtent: 320,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: [
                GridTileLogo(
                  title: 'Courses',
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
                    showMsg(context, 'Hehe');
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
                    // navigatorPush(context, );
                    showMsg(context, 'Hehe');
                  },
                ),
                GridTileLogo(
                  title: 'Your Feedbacks',
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    size: 50,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    // navigatorPush(context, );
                    showMsg(context, 'Hehe');
                  },
                ),
              ],
            ),
            Expanded(
              child: Align(
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
            ),
          ],
        ),
      ),
    );
  }
}
