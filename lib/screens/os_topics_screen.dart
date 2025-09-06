// lib/screens/os_topics_screen.dart
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'flashcard_screen.dart';

class OSTopicsScreen extends StatelessWidget {
  const OSTopicsScreen({super.key});

  final topics = const [
    "Processes & Threads",
    "Scheduling Algorithms",
    "Memory Management",
    "Virtual Memory",
    "File Systems",
    "Synchronization",
    "Deadlocks",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Operating Systems"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Card(
              color: theme.cardColor.withOpacity(0.8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(topics[index], style: theme.textTheme.titleMedium),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FlashcardScreen(topic: topics[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
