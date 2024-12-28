import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_progress.dart';
import '../services/progress_service.dart';

class ProgressPage extends StatelessWidget {
  final ProgressService _progressService = ProgressService();

  ProgressPage({super.key});

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Progrès'),
      ),
      body: StreamBuilder<List<UserProgress>>(
        stream: _progressService.getUserProgress(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final progress = snapshot.data!;
          
          if (progress.isEmpty) {
            return const Center(
              child: Text('Aucune séance complétée pour le moment'),
            );
          }

          return ListView.builder(
            itemCount: progress.length,
            itemBuilder: (context, index) {
              final session = progress[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  title: Text(
                    'Séance du ${session.completedDate.day}/'
                    '${session.completedDate.month}/'
                    '${session.completedDate.year}',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Durée: ${_formatDuration(session.duration)}'),
                      if (session.notes.isNotEmpty)
                        Text('Notes: ${session.notes}'),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < session.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
