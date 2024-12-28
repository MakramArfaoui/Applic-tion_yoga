import 'package:flutter/material.dart';
import '../models/yoga_session.dart';
import 'session_detail_page.dart';

class SessionCard extends StatelessWidget {
  final YogaSession session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: session.imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  session.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.fitness_center),
              ),
        title: Text(session.title),
        subtitle: Text('${session.duration} minutes'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionDetailPage(session: session),
            ),
          );
        },
      ),
    );
  }
}
