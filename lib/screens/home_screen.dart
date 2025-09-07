import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

// Topic screens
import 'dsa_topics_screen.dart';
import 'algorithms_topics_screen.dart';
import 'os_topics_screen.dart';
import 'networking_topics_screen.dart';
import 'database_topics_screen.dart';
import 'ml_topics_screen.dart';
import 'ai_topics_screen.dart';
import 'architecture_topics_screen.dart';
import 'cybersecurity_topics_screen.dart';
import 'se_topics_screen.dart';

// Main section screens
import 'courses_screen.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'help_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomeScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final subjects = [
    'Data Structures',
    'Algorithms',
    'Operating Systems',
    'Networking',
    'Databases',
    'Machine Learning',
    'Artificial Intelligence',
    'Computer Architecture',
    'Cybersecurity',
    'Software Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final gradientColors = theme.brightness == Brightness.light
        ? [
            const Color(0xFFFDE2E4),
            const Color(0xFFFAD2E1),
            const Color(0xFFD7E3FC),
            const Color(0xFFE2ECE9),
          ]
        : const [Color(0xFF3E1E68), Color(0xFF2A0E4C), Color(0xFF0D0D0D)];

    final elementColor = Colors.white.withOpacity(0.2);
    final subjectTextColor = theme.brightness == Brightness.light
        ? Colors.black87
        : Colors.white;

    // Decide body based on bottom nav
    Widget body;
    switch (_selectedIndex) {
      case 1:
        body = const CoursesScreen();
        break;
      case 2:
        body = const ExploreScreen();
        break;
      default:
        body = _buildHomeContent(
          theme,
          screenWidth,
          gradientColors,
          elementColor,
          subjectTextColor,
        );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(
                      onToggleTheme: widget.onToggleTheme,
                      isDark: theme.brightness == Brightness.dark,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GradientBackground(child: body),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
        selectedItemColor: theme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        unselectedItemColor: theme.brightness == Brightness.dark
            ? Colors.white70
            : Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        ],
      ),
    );
  }

  Widget _buildHomeContent(
    ThemeData theme,
    double screenWidth,
    List<Color> gradientColors,
    Color elementColor,
    Color subjectTextColor,
  ) {
    return Column(
      children: [
        const SizedBox(height: 80),
        // Progress Tracker Circle
        Center(
          child: Container(
            width: screenWidth * 0.4,
            height: screenWidth * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: elementColor,
            ),
            child: Center(
              child: Text(
                '3/10',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: subjectTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: subjects.map((subject) {
                final boxSize = (screenWidth - 48) / 2;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _getTopicScreen(subject),
                      ),
                    );
                  },
                  child: Container(
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      color: elementColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        subject,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: subjectTextColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSerifText',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Map subjects to their topic screens
  Widget _getTopicScreen(String subject) {
    switch (subject) {
      case 'Data Structures':
        return const DSATopicsScreen();
      case 'Algorithms':
        return const AlgorithmsTopicsScreen();
      case 'Operating Systems':
        return const OSTopicsScreen();
      case 'Networking':
        return const NetworkingTopicsScreen();
      case 'Databases':
        return const DatabasesTopicsScreen();
      case 'Machine Learning':
        return const MLTopicsScreen();
      case 'Artificial Intelligence':
        return const AITopicsScreen();
      case 'Computer Architecture':
        return const ArchitectureTopicsScreen();
      case 'Cybersecurity':
        return const CybersecurityTopicsScreen();
      case 'Software Engineering':
        return const SETopicsScreen();
      default:
        return const DSATopicsScreen();
    }
  }
}
