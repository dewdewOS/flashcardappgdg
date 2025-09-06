import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';

class FlashcardAIService {
  /// Generates a single flashcard for a given topic
  /// Returns a Map with keys: "question" and "answer"
  static Future<Map<String, String>> generateFlashcard(String topic) async {
    try {
      final response = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "You are a helpful tutor generating flashcards for Data Structures.",
              ),
            ],
          ),
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                "Generate ONE flashcard about '$topic'. "
                "Try to return valid JSON like {\"question\": \"...\", \"answer\": \"...\"}. "
                "If you cannot, return text starting with 'Q:' and 'A:'.",
              ),
            ],
          ),
        ],
      );

      final text =
          response.choices.first.message.content?.first.text?.trim() ?? "";
      print("Raw AI response for $topic: $text");

      // 1️⃣ Try JSON first
      try {
        final data = jsonDecode(text);
        if (data is Map<String, dynamic>) {
          final question = data["question"]?.toString().trim();
          final answer = data["answer"]?.toString().trim();
          if (question != null && answer != null) {
            return {"question": question, "answer": answer};
          }
        }
      } catch (_) {
        // JSON parsing failed, continue to Q:/A: parsing
      }

      // 2️⃣ Try parsing Q: ... A: ... format
      final qIndex = text.indexOf("Q:");
      final aIndex = text.indexOf("A:");
      if (qIndex != -1 && aIndex != -1 && aIndex > qIndex) {
        final question = text.substring(qIndex + 2, aIndex).trim();
        final answer = text.substring(aIndex + 2).trim();
        return {"question": question, "answer": answer};
      }

      // 3️⃣ Fallback if all parsing fails
      return {
        "question": "Example question for $topic",
        "answer": "Example answer for $topic",
      };
    } catch (e) {
      print("AI service error for $topic: $e");

      // Fallback flashcard on API/network error
      return {
        "question": "Example question for $topic",
        "answer": "Example answer for $topic",
      };
    }
  }
}
