import 'package:feedback_hub/models/academic_record.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class AcademicRecordsScrollView extends StatelessWidget {
  const AcademicRecordsScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Your Grades",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        FutureBuilder(
          future: fetchAcademicRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicator();
            }
            final records = snapshot.data;
            if (records != null) {
              records.removeWhere((element) => element.grade == null);
            }
            if (records == null || records.isEmpty) {
              return const Text(
                'You Aren\'t Graded Yet',
                textAlign: TextAlign.center,
              );
            }
            return SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return AcademicRecordTile(record: records[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: records.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class AcademicRecordTile extends StatelessWidget {
  final AcademicRecord record;
  const AcademicRecordTile({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        // child: Text(record.name ?? record.courseId),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (record.grade != null)
                Text(
                  gradePointToGrade(record.grade!),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              if (record.course != null)
                Text(record.course!.name ?? record.course!.courseId,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center),
              if (record.instructor != null)
                Text(
                    record.instructor!.name ??
                        record.instructor!.email ??
                        record.instructor!.id.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                    textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
