import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFavoriteItem(
            'Yoga Matinal',
            '30 minutes',
            'Routine énergisante',
            Icons.wb_sunny,
          ),
          _buildFavoriteItem(
            'Méditation du Soir',
            '15 minutes',
            'Relaxation profonde',
            Icons.nightlight_round,
          ),
          _buildFavoriteItem(
            'Respiration Alternée',
            '10 minutes',
            'Équilibrage énergétique',
            Icons.air,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(String title, String duration, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple[100],
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(title),
        subtitle: Text('$duration - $description'),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            // Retirer des favoris
          },
        ),
      ),
    );
  }
}
