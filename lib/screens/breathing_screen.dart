import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/breathing_exercise.dart';
import '../widgets/breathing_exercise_card.dart';

class BreathingScreen extends StatelessWidget {
  const BreathingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BreathingExercise> breathingExercises = [
      BreathingExercise(
        name: 'Respiration carrée',
        description: 'Inspirez pendant 4s, retenez 4s, expirez 4s, retenez 4s',
        duration: '5 minutes',
        imageUrl: 'assets/images/square_breathing.jpg',
      ),
      BreathingExercise(
        name: 'Respiration alternée',
        description: 'Alternez la respiration entre les narines gauche et droite',
        duration: '10 minutes',
        imageUrl: 'assets/images/alternate_breathing.jpg',
      ),
      BreathingExercise(
        name: 'Respiration profonde',
        description: 'Inspirez profondément par le nez, expirez lentement par la bouche',
        duration: '7 minutes',
        imageUrl: 'assets/images/deep_breathing.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercices de respiration'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: breathingExercises.length,
        itemBuilder: (context, index) {
          return BreathingExerciseCard(
            exercise: breathingExercises[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BreathingExerciseDetailScreen(
                    exercise: breathingExercises[index],
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

class BreathingExerciseDetailScreen extends StatefulWidget {
  final BreathingExercise exercise;

  const BreathingExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<BreathingExerciseDetailScreen> createState() => _BreathingExerciseDetailScreenState();
}

class _BreathingExerciseDetailScreenState extends State<BreathingExerciseDetailScreen> {
  bool _isPlaying = false;
  int _remainingSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.exercise.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.exercise.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.exercise.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Durée: ${widget.exercise.duration}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      label: Text(_isPlaying ? 'Pause' : 'Commencer'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
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
