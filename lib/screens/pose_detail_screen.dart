import 'package:flutter/material.dart';

class PoseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> pose;

  const PoseDetailScreen({super.key, required this.pose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pose['name'],
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pose['name'],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Chip(
                        label: Text(pose['niveau']),
                        backgroundColor: pose['niveau'] == 'Débutant'
                            ? Colors.green[100]
                            : Colors.orange[100],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sanskrit: ${pose["sanskrit"]}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Bénéfices',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Améliore la posture et l\'équilibre\n'
                    '• Renforce les muscles du centre\n'
                    '• Augmente la flexibilité\n'
                    '• Réduit le stress et l\'anxiété',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Commencez en position debout, pieds joints\n'
                    '2. Gardez vos bras le long du corps\n'
                    '3. Répartissez votre poids uniformément\n'
                    '4. Gardez votre colonne vertébrale droite\n'
                    '5. Respirez profondément',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
