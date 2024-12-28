import 'package:flutter/material.dart';

class AdvancedYogaScreen extends StatelessWidget {
  const AdvancedYogaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Avancé'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAdvancedSession(
            'Ashtanga Yoga',
            '60 minutes',
            'Série avancée dynamique',
            Icons.fitness_center,
          ),
          _buildAdvancedSession(
            'Inversions',
            '45 minutes',
            'Pratique des postures inversées',
            Icons.rotate_right,
          ),
          _buildAdvancedSession(
            'Flow Dynamique',
            '50 minutes',
            'Vinyasa flow avancé',
            Icons.waves,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSession(String title, String duration, String description, IconData icon) {
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
