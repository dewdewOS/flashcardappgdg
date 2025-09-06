import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flashcardappgdg/services/ai_service.dart';

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
  final int totalCards = 10; // can make dynamic
  int retryCount = 0;
  final int maxRetries = 3;

  @override
  void initState() {
    super.initState();
    _loadFlashcard();
  }

  /// Load a flashcard with timeout, retry, and fallback
  Future<void> _loadFlashcard() async {
    setState(() => loading = true);

    try {
      // Attempt to get flashcard with 10s timeout
      final flashcard = await FlashcardAIService.generateFlashcard(
        widget.topic,
      ).timeout(const Duration(seconds: 10));

      // Check for null / empty
      if (flashcard == null ||
          flashcard["question"] == null ||
          flashcard["answer"] == null) {
        throw Exception("Invalid flashcard data");
      }

      setState(() {
        question = flashcard["question"]!;
        answer = flashcard["answer"]!;
        loading = false;
        retryCount = 0; // reset retry counter
      });
    } catch (e) {
      debugPrint("Flashcard load error: $e");

      if (retryCount < maxRetries) {
        retryCount++;
        debugPrint("Retrying... attempt $retryCount");
        await Future.delayed(const Duration(seconds: 1));
        _loadFlashcard(); // retry
      } else {
        // Fallback card after retries exhausted
        setState(() {
          question = "Example question for ${widget.topic}";
          answer = "Example answer for ${widget.topic}";
          loading = false;
        });
      }
    }
  }

  void _nextCard() {
    if (currentIndex < totalCards) {
      setState(() => currentIndex++);
      _loadFlashcard();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You reached the last card.")),
      );
    }
  }

  Widget _buildCard(String text) {
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
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B4DED),
      appBar: AppBar(
        title: Text("Learning ${widget.topic}"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: _buildCard(question),
                        back: _buildCard(answer),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: currentIndex / totalCards,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    color: Colors.white,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$currentIndex/$totalCards",
                    style: const TextStyle(color: Colors.white),
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
                    onPressed: _nextCard,
                    child: const Text("Next Card"),
                  ),
                ],
              ),
            ),
    );
  }
}
