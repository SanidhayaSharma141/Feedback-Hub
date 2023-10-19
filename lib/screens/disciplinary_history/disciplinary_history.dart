import 'package:feedback_hub/tools.dart';
import 'package:feedback_hub/widgets/section.dart';
import 'package:flutter/material.dart';

class AcademicRecordScreen extends StatelessWidget {
  const AcademicRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shaderText(context, title: 'Courses'),
      ),
      body: ListView(
        children: const [
          Section(
            title: 'Semester 1',
            children: [
              // course tiles
            ],
          ),
          Section(
            title: 'Semester 2',
            children: [
              // course tiles
            ],
          ),
        ],
      ),
    );
  }
}
