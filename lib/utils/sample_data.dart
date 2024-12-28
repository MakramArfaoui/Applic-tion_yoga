import 'package:cloud_firestore/cloud_firestore.dart';

class SampleData {
  static Future<void> addSampleCourses() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Exemple de cours pour la catégorie "Débutant"
    await firestore.collection('courses').add({
      'title': 'Introduction au Yoga',
      'description': 'Un cours parfait pour débuter votre pratique du yoga en douceur',
      'categoryId': 'debutant', // Assurez-vous que cet ID correspond à votre catégorie
      'videoUrl': 'https://example.com/video1.mp4', // Remplacez par une vraie URL vidéo
      'thumbnail': 'https://example.com/thumbnail1.jpg', // Remplacez par une vraie URL d'image
      'instructions': [
        'Commencez en position de montagne',
        'Respirez profondément pendant 5 respirations',
        'Passez doucement en posture de l\'enfant',
        'Maintenez la position pendant 1 minute'
      ],
      'duration': '20 min',
      'level': 'Débutant'
    });

    // Cours pour la catégorie "Intermédiaire"
    await firestore.collection('courses').add({
      'title': 'Flow Dynamique',
      'description': 'Une séquence fluide pour renforcer votre pratique',
      'categoryId': 'intermediaire',
      'videoUrl': 'https://example.com/video2.mp4',
      'thumbnail': 'https://example.com/thumbnail2.jpg',
      'instructions': [
        'Démarrez en posture du chien tête en bas',
        'Enchaînez avec une planche',
        'Passez en cobra',
        'Revenez en chien tête en bas'
      ],
      'duration': '30 min',
      'level': 'Intermédiaire'
    });

    // Cours pour la catégorie "Avancé"
    await firestore.collection('courses').add({
      'title': 'Inversions Avancées',
      'description': 'Perfectionnez vos équilibres sur les mains',
      'categoryId': 'avance',
      'videoUrl': 'https://example.com/video3.mp4',
      'thumbnail': 'https://example.com/thumbnail3.jpg',
      'instructions': [
        'Échauffement des poignets',
        'Pratique du crow pose',
        'Transition vers l\'équilibre sur les mains',
        'Variations avancées'
      ],
      'duration': '45 min',
      'level': 'Avancé'
    });
  }
}
