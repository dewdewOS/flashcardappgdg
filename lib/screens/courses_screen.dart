import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  final List<String> myCourses = const [
    "Flutter Basics",
    "Advanced Python",
    "Java Fundamentals",
  ];

  final List<String> favouriteCourses = const [
    "Machine Learning",
    "Data Structures",
    "Cybersecurity 101",
  ];

  final List<String> bookmarkedCourses = const [
    "SQL for Beginners",
    "Deep Learning",
    "Web Development",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildCourseSection(String title, List<String> courses) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final course = courses[index];
                return Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Text(
                      course,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Courses Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                buildCourseSection("My Courses", myCourses),
                buildCourseSection("Favourite Courses", favouriteCourses),
                buildCourseSection("Bookmarked Courses", bookmarkedCourses),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
