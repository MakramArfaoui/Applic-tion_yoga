import 'package:flutter/material.dart';
import '../models/yoga_session.dart';
import 'session_player_page.dart';
import '../services/session_service.dart';

class SessionDetailPage extends StatelessWidget {
  final YogaSession session;
  final SessionService _sessionService = SessionService();

  SessionDetailPage({super.key, required this.session});

  Future<void> _cancelSession(BuildContext context) async {
    try {
      await _sessionService.cancelSession(session.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Séance annulée avec succès'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'annulation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(session.title),
              background: Image.network(
                session.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text('${session.duration} min'),
                        avatar: const Icon(Icons.timer),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(session.difficulty),
                        avatar: const Icon(Icons.fitness_center),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(session.description),
                  const SizedBox(height: 16),
                  const Text(
                    'Postures',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: session.poses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(session.poses[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionPlayerPage(session: session),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Commencer la séance',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Annuler la séance'),
                      content: const Text('Voulez-vous vraiment annuler cette séance ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Non'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _cancelSession(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Oui, annuler'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.red),
              label: const Text(
                'Annuler la séance',
                style: TextStyle(color: Colors.red),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
