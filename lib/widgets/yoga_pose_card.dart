import 'package:flutter/material.dart';

class YogaPoseCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String difficulty;
  final String duration;

  const YogaPoseCard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.difficulty,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Chip(
                      label: Text(difficulty),
                      backgroundColor: _getDifficultyColor(difficulty),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(duration),
                      backgroundColor: Colors.blue[100],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green[100]!;
      case 'intermediate':
        return Colors.orange[100]!;
      case 'advanced':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
