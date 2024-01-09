import 'package:flutter/material.dart';

class ChartBarVertical extends StatelessWidget {
  const ChartBarVertical({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              shape: BoxShape.rectangle,
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.85)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartBarHorizontal extends StatelessWidget {
  const ChartBarHorizontal({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: FractionallySizedBox(
          widthFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.horizontal(right: Radius.circular(8)),
              shape: BoxShape.rectangle,
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.85)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
