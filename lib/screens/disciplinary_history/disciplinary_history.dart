import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class DisciplinaryScreen extends StatelessWidget {
  const DisciplinaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Your Disciplinary Record'),
      ),
      body: ListView(
        children: const [
          Section(
            title: 'Level 1 Offense',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Anti Ragging Charges"),
                    leading: Icon(Icons.dangerous),
                    subtitle: Text("Suspension-2 Months"),
                    children: [
                      Text(
                          "Anubhav Singh found himself at the center of a ragging incident that took place in his college. Ragging refers to the act of hazing or subjecting newcomers to various forms of harassment or humiliation, and it is typically considered unacceptable and against college policies. In this particular incident, Anubhav Singh's involvement in the ragging activities led to his suspension for a period of two months as a disciplinary measure. This decision was taken by the college authorities to ensure the safety and well-being of students and to send a clear message against such behavior.")
                    ],
                  ),
                ],
              )
            ],
          ),
          Section(
            title: 'Level 2 Offense',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Physical Fight with Junior"),
                    leading: Icon(Icons.dangerous),
                    subtitle: Text("Apology letter taken"),
                    children: [
                      Text(
                          "Anubhav Singh was involved in a regrettable incident during a basketball game in his college. While playing, a physical altercation occurred between him and a junior student. This unfortunate incident led to an official intervention by the college authorities. Anubhav was required to write an apology letter, expressing remorse for his actions and assuring that there would be no repetition of such behavior in the next six months. The college took this step to promote a safe and respectful environment for all students and to prevent any further instances of physical confrontation.")
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
