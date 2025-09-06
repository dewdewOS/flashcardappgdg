import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.brightness == Brightness.dark
              ? [
                  const Color.fromARGB(255, 48, 28, 67),
                  const Color.fromARGB(255, 52, 21, 50),
                ]
              : [
                  const Color.fromARGB(255, 165, 186, 231),
                  Colors.purple.shade100,
                ],
        ),
      ),
      child: child,
    );
  }
}
