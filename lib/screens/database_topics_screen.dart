// lib/screens/databases_topics_screen.dart
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'flashcard_screen.dart';

class DatabasesTopicsScreen extends StatelessWidget {
  const DatabasesTopicsScreen({super.key});

  final topics = const [
    "Relational Databases",
    "SQL Queries",
    "Normalization",
    "Transactions",
    "Indexes",
    "NoSQL Databases",
    "Stored Procedures",
    "Triggers",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Databases"),
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
