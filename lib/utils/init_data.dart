import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> initializeYogaPoses() async {
  final firestore = FirebaseFirestore.instance;
  final yogaPosesCollection = firestore.collection('yoga_poses');

  final poses = [
    {
      'name': 'Posture du Chien Tête en Bas',
      'description': 'Une posture d\'étirement qui renforce tout le corps et améliore la flexibilité.',
      'imageUrl': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b',
      'difficulty': 'Débutant',
      'durationInMinutes': 5,
      'benefits': [
        'Étire la colonne vertébrale',
        'Renforce les bras et les jambes',
        'Améliore la circulation sanguine',
        'Calme l\'esprit'
      ],
    },
    {
      'name': 'Posture du Guerrier I',
      'description': 'Une posture debout qui développe la force et la stabilité.',
      'imageUrl': 'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b',
      'difficulty': 'Intermédiaire',
      'durationInMinutes': 8,
      'benefits': [
        'Renforce les jambes',
        'Ouvre les hanches',
        'Améliore l\'équilibre',
        'Développe la concentration'
      ],
    },
    {
      'name': 'Posture du Lotus',
      'description': 'Une posture de méditation classique qui favorise la concentration.',
      'imageUrl': 'https://images.unsplash.com/photo-1545389336-cf090694435e',
      'difficulty': 'Avancé',
      'durationInMinutes': 15,
      'benefits': [
        'Améliore la posture',
        'Calme le mental',
        'Favorise la méditation',
        'Ouvre les hanches'
      ],
    },
  ];

  for (final pose in poses) {
    await yogaPosesCollection.add(pose);
  }
}
