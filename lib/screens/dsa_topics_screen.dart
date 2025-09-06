import 'package:flutter/material.dart';
import 'flashcard_screen.dart';

class DSATopicsScreen extends StatelessWidget {
  const DSATopicsScreen({super.key});

  final topics = const [
    "Arrays",
    "Linked List",
    "Stacks",
    "Queues",
    "Trees",
    "Graphs",
    "Hashing",
    "Recursion",
    "Dynamic Programming",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("DSA Topics"),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FlashcardScreen(topic: topics[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
