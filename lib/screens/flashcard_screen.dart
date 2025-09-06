import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../services/ai_service.dart';
import '../widgets/gradient_background.dart';

class FlashcardScreen extends StatefulWidget {
  final String topic;
  const FlashcardScreen({super.key, required this.topic});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  String question = "";
  String answer = "";
  bool loading = true;
  int currentIndex = 1;
  int totalCards = 10;

  @override
  void initState() {
    super.initState();
    _loadFlashcard();
  }

  Future<void> _loadFlashcard() async {
    setState(() => loading = true);
    try {
      final flashcard = await FlashcardAIService.generateFlashcard(
        widget.topic,
      );
      print("Flashcard returned: $flashcard");
      setState(() {
        question = flashcard["question"] ?? "";
        answer = flashcard["answer"] ?? "";
        loading = false;
      });
    } catch (e) {
      print("AI service error for ${widget.topic}: $e");
      setState(() {
        question = "Error loading question";
        answer = "Check your API key or quota";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Learning ${widget.topic}"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: _buildCard(question, theme),
                          back: _buildCard(answer, theme),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        LinearProgressIndicator(
                          value: currentIndex / totalCards,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          color: Colors.white,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "$currentIndex/$totalCards",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (currentIndex < totalCards) {
                          setState(() {
                            currentIndex++;
                            _loadFlashcard();
                          });
                        }
                      },
                      child: const Text("Next Card"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCard(String text, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
