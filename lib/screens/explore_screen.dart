import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _searchQuery = "";

  final Map<String, List<String>> courses = {
    "Programming": [
      "Python for Beginners",
      "Advanced C++",
      "Java Fundamentals",
      "Flutter Development",
      "Web Development with JavaScript",
    ],
    "Data Science": [
      "Data Structures & Algorithms",
      "Machine Learning Basics",
      "Deep Learning with TensorFlow",
      "Data Visualization with Python",
      "Statistics for Data Science",
    ],
    "Artificial Intelligence": [
      "AI Fundamentals",
      "Natural Language Processing",
      "Computer Vision",
      "Reinforcement Learning",
    ],
    "Cybersecurity": [
      "Introduction to Cybersecurity",
      "Network Security",
      "Ethical Hacking",
      "Cryptography",
    ],
    "Databases": [
      "SQL for Beginners",
      "Advanced Database Design",
      "NoSQL Databases",
      "Database Optimization",
    ],
    "Software Engineering": [
      "Agile Methodologies",
      "System Design Fundamentals",
      "Version Control with Git",
      "DevOps Basics",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Filter courses based on search query
    final filteredCourses = courses.map((category, courseList) {
      final filtered = courseList
          .where(
            (course) =>
                course.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
      return MapEntry(category, filtered);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Explore Courses"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  decoration: InputDecoration(
                    hintText: "Search courses...",
                    hintStyle: TextStyle(color: theme.hintColor),
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.iconTheme.color,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: filteredCourses.entries.map((entry) {
                      final category = entry.key;
                      final courseList = entry.value;

                      if (courseList.isEmpty) return const SizedBox.shrink();

                      return Theme(
                        data: theme.copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            category,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          children: courseList.map((course) {
                            return ListTile(
                              title: Text(
                                course,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              leading: Icon(
                                Icons.book,
                                color: theme.iconTheme.color,
                              ),
                              tileColor: Colors.white.withOpacity(0.05),
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Selected: $course")),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
