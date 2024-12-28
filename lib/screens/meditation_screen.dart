import 'package:flutter/material.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Méditation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMeditationSession(
            'Méditation Guidée',
            '10 minutes',
            'Relaxation profonde',
            Icons.spa,
          ),
          _buildMeditationSession(
            'Pleine Conscience',
            '15 minutes',
            'Pratique de la mindfulness',
            Icons.psychology,
          ),
          _buildMeditationSession(
            'Méditation du Soir',
            '20 minutes',
            'Pour un sommeil réparateur',
            Icons.nightlight_round,
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationSession(String title, String duration, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: Colors.deepPurple),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        duration,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Commencer'),
            ),
          ],
        ),
      ),
    );
  }
}
