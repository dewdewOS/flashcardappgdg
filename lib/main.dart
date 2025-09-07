import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_openai/dart_openai.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  await dotenv.load();

  final apiKey = dotenv.env['OPENAI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception("OPENAI_API_KEY is missing in .env");
  }

  OpenAI.apiKey = apiKey;
  print("OpenAI API key loaded successfully!");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      // Define routes for navigation
      routes: {
        '/': (context) => HomeScreen(onToggleTheme: _toggleTheme),
        '/courses': (context) => const CoursesScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) =>
            SettingsScreen(onToggleTheme: _toggleTheme, isDark: _isDark),
        '/help': (context) => const HelpScreen(),
      },
    );
  }
}

// --------------------------------------------------------
// Test function to verify AI returns a flashcard for Arrays
Future<void> testFlashcardAPI() async {
  try {
    final response = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              "Generate ONE flashcard about Arrays in JSON format: {\"question\": \"...\", \"answer\": \"...\"}",
            ),
          ],
        ),
      ],
    );

    final text = response.choices.first.message.content?.first.text?.trim();
    print("Raw AI output for Arrays:\n$text");
  } catch (e) {
    print("OpenAI API test error: $e");
  }
}
