import 'package:feedback_hub/tools.dart';
import 'package:flutter/material.dart';

class GridTileLogo extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color color;
  final void Function()? onTap;
  const GridTileLogo({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: title.replaceAll('_', ' '),
      child: GlassWidget(
        radius: 30,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: color.withOpacity(0.2),
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title.replaceAll('_', ' '),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  icon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
