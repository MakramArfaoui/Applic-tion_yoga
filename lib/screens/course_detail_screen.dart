import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/yoga_course.dart';

class CourseDetailScreen extends StatelessWidget {
  final YogaCourse course;

  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  Future<void> _launchYouTube() async {
    final Uri url = Uri.parse(course.videoUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          course.title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations de base
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(course.duration),
                    avatar: const Icon(Icons.timer, size: 16),
                  ),
                  Chip(
                    label: Text(course.level),
                    avatar: const Icon(Icons.fitness_center, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(course.description),
              const SizedBox(height: 24),

              // Lien vidéo
              Text(
                'Lien de la vidéo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              SelectableText(
                course.videoUrl,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 24),

              // Bouton pour regarder la vidéo
              Center(
                child: ElevatedButton.icon(
                  onPressed: _launchYouTube,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Regarder la vidéo sur YouTube'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Instructions
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: course.instructions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${index + 1}. '),
                        Expanded(
                          child: Text(course.instructions[index]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
