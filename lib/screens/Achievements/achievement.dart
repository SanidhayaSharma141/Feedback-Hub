import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Your Achievements'),
      ),
      body: ListView(
        children: const [
          Section(
            title: 'Semester 1',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Best Sportsperson"),
                    leading: Icon(Icons.sports),
                    children: [
                      Text(
                          "Santosh Dodhi achieved the title of the best sportsperson in college, showcasing remarkable talent and dedication in various sports. His outstanding performance and commitment earned him this well-deserved recognition.")
                    ],
                  ),
                ],
              )
            ],
          ),
          Section(
            title: 'Semester 2',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Student Of The Year- Santosh Dodhi"),
                    leading: Icon(Icons.personal_injury_rounded),
                    children: [
                      Text(
                          "Santosh Dodhi achieved the title of \"Student of the Year\" due to exceptional academic performance, active participation in extracurricular activities, and strong leadership qualities. His well-rounded excellence made him the deserving recipient of this prestigious recognition.")
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
