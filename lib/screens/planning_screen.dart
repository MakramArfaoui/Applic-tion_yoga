import 'package:flutter/material.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Ajouter une nouvelle séance
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDaySchedule('Lundi'),
          _buildDaySchedule('Mardi'),
          _buildDaySchedule('Mercredi'),
          _buildDaySchedule('Jeudi'),
          _buildDaySchedule('Vendredi'),
          _buildDaySchedule('Samedi'),
          _buildDaySchedule('Dimanche'),
        ],
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        title: Text(
          day,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Yoga du Matin'),
            subtitle: const Text('7:00 - 8:00'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.self_improvement),
            title: const Text('Méditation'),
            subtitle: const Text('18:00 - 18:30'),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
