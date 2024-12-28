import 'package:flutter/material.dart';

class BeginnerYogaScreen extends StatelessWidget {
  const BeginnerYogaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Débutant'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildYogaSession(
            'Introduction au Yoga',
            '15 minutes',
            'Parfait pour commencer',
            Icons.accessibility_new,
          ),
          _buildYogaSession(
            'Postures de Base',
            '20 minutes',
            'Apprentissage des asanas fondamentales',
            Icons.self_improvement,
          ),
          _buildYogaSession(
            'Respiration Consciente',
            '10 minutes',
            'Techniques de pranayama simples',
            Icons.air,
          ),
        ],
      ),
    );
  }

  Widget _buildYogaSession(String title, String duration, String description, IconData icon) {
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
