import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Frequently Asked Questions",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ExpansionTile(
            title: const Text("How do I use flashcards?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Go to any subject, open a topic, and flip the flashcards to test yourself.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text("How do I enable dark mode?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can enable dark mode from Settings or by tapping the sun/moon icon.",
                ),
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Contact Support"),
            subtitle: const Text("support@flashcardsapp.com"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
