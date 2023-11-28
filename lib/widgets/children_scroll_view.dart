import 'package:feedback_hub/models/parent.dart';
import 'package:feedback_hub/models/user.dart';
import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class ChildrenScrollView extends StatelessWidget {
  const ChildrenScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Your Children",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        FutureBuilder(
          future: fetchChildren(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicator();
            }
            final children = snapshot.data;
            if (children == null || children.isEmpty) {
              return const Text(
                  'You have no children enrolled in this institution');
            }
            return SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChildTile(child: children[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: children.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ChildTile extends StatelessWidget {
  UserData child;
  ChildTile({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        // child: Text(course.name ?? course.courseId),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: fetchUserData(child.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                child = snapshot.data!;
              }
              bool stillLoading =
                  snapshot.connectionState == ConnectionState.waiting;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(child.name ?? child.id.toString(),
                      textAlign: TextAlign.center),
                  if (stillLoading && child.studentData == null)
                    circularProgressIndicator(),
                  if (child.studentData != null)
                    Text(child.studentData!.rollNumber!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
