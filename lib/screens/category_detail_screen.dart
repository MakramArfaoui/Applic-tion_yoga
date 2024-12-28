import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:yoga_app/models/yoga_course.dart';
import 'package:yoga_app/services/firebase_service.dart';
import 'package:yoga_app/theme_provider.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  const CategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryTitle,
  }) : super(key: key);

  Future<void> _launchYouTube(String videoUrl) async {
    final Uri url = Uri.parse(videoUrl);
    if (!await url_launcher.launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final firebaseService = Provider.of<FirebaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<YogaCourse>>(
        stream: firebaseService.getCoursesByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final courses = snapshot.data ?? [];

          if (courses.isEmpty) {
            return const Center(
              child: Text('Aucun cours disponible dans cette catégorie'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final YogaCourse course = courses[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        course.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(course.description),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Text(course.duration),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.fitness_center,
                                size: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Text(course.level),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () => _launchYouTube(course.videoUrl),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Regarder sur YouTube'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
