import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
        title: shaderText(context, title: 'Your Feedback'),
      ),
      body: ListView(
        children: const [
          Section(
            title: 'Alka Chaddha',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Covering Additional Topics"),
                    subtitle: Text("Course: Mathematics-II"),
                    children: [
                      Text(
                          "Dear Dr. Alka Chaddha,I've been thoroughly enjoying your Mathematics II class. Could we explore some additional topics in the subject to enhance our understanding? Your expertise would be invaluable in this endeavor.Thank you for your consideration.")
                    ],
                  ),
                ],
              )
            ],
          ),
          Section(
            title: 'Warden-Federal',
            children: [
              Column(
                children: [
                  ExpansionTile(
                    title: Text("Electricity and water scarcity"),
                    subtitle: Text("Urgent solution required!!"),
                    children: [
                      Text(
                          "I am writing to express my concern about the persistent issues of electricity and water scarcity in the Federal Hostel. These problems have been causing significant inconvenience to the residents, and I kindly request your prompt attention to resolve them.")
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
