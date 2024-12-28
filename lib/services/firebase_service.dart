import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/yoga_course.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getCategories() {
    // Données statiques pour le développement
    final categories = [
      {
        'id': 'debutant',
        'name': 'Débutant',
        'description': 'Pour commencer le yoga en douceur',
        'color': '0xFF4CAF50',
        'icon': 'self_improvement',
      },
      {
        'id': 'intermediaire',
        'name': 'Intermédiaire',
        'description': 'Pour progresser dans votre pratique',
        'color': '0xFF2196F3',
        'icon': 'fitness_center',
      },
      {
        'id': 'avance',
        'name': 'Avancé',
        'description': 'Pour les yogis expérimentés',
        'color': '0xFF9C27B0',
        'icon': 'sports_gymnastics',
      },
      {
        'id': 'meditation',
        'name': 'Méditation',
        'description': 'Pour la relaxation et la pleine conscience',
        'color': '0xFF673AB7',
        'icon': 'spa',
      },
      {
        'id': 'matinal',
        'name': 'Yoga Matinal',
        'description': 'Pour bien commencer la journée',
        'color': '0xFFFF9800',
        'icon': 'wb_sunny',
      },
      {
        'id': 'prenatal',
        'name': 'Yoga Prénatal',
        'description': 'Adapté aux futures mamans',
        'color': '0xFFE91E63',
        'icon': 'pregnant_woman',
      },
    ];

    return Stream.value(categories);
  }

  Stream<List<YogaCourse>> getCoursesByCategory(String categoryId) {
    const defaultThumbnail = 'assets/images/placeholder.svg';
    final courses = [
      // Vidéos pour débutants
      {
        'id': '1',
        'title': 'Yoga pour Débutants - Séance 1',
        'description': 'Première séance de yoga pour bien débuter',
        'categoryId': 'debutant',
        'videoUrl': 'https://youtu.be/Jsd2vxaRTf4?si=VwOMyDIxxMHqwz3f',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Installez-vous sur votre tapis',
          'Suivez les mouvements doucement',
          'Respirez profondément',
        ],
        'duration': '20 min',
        'level': 'Débutant',
      },
      {
        'id': '2',
        'title': 'Yoga pour Débutants - Séance 2',
        'description': 'Deuxième séance pour renforcer les bases',
        'categoryId': 'debutant',
        'videoUrl': 'https://youtu.be/L_xrDAtykMI?si=PZi2uh4l1jai3WyM',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Préparez un espace calme',
          'Écoutez votre corps',
          'Prenez votre temps',
        ],
        'duration': '25 min',
        'level': 'Débutant',
      },
      // Vidéos intermédiaires
      {
        'id': '3',
        'title': 'Yoga Intermédiaire - Flow Dynamique',
        'description': 'Séance de yoga dynamique pour niveau intermédiaire',
        'categoryId': 'intermediaire',
        'videoUrl': 'https://youtu.be/nmCjK6qKDpI?si=EUfV6U8MrspFnyJm',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Maintenez une respiration régulière',
          'Alignez bien vos postures',
          'Restez concentré sur vos sensations',
        ],
        'duration': '30 min',
        'level': 'Intermédiaire',
      },
      // Vidéos avancées
      {
        'id': '4',
        'title': 'Yoga Avancé - Postures Complexes',
        'description': 'Séance avancée avec des postures complexes',
        'categoryId': 'avance',
        'videoUrl': 'https://youtu.be/JlmN-3RUlBQ?si=YBSdZjS-Phy9Fq8e',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Échauffez-vous bien',
          'Respectez vos limites',
          'Concentrez-vous sur la précision',
        ],
        'duration': '45 min',
        'level': 'Avancé',
      },
      // Vidéos de méditation
      {
        'id': '5',
        'title': 'Méditation Guidée',
        'description': 'Séance de méditation pour la relaxation',
        'categoryId': 'meditation',
        'videoUrl': 'https://youtu.be/o_73FeXw3ZI?si=BhCmy1WKNBNSOBjy',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Trouvez un endroit calme',
          'Asseyez-vous confortablement',
          'Suivez la voix guide',
        ],
        'duration': '15 min',
        'level': 'Tous niveaux',
      },
      // Vidéos de yoga matinal
      {
        'id': '6',
        'title': 'Yoga Matinal - Réveil en Douceur',
        'description': 'Séance de yoga pour bien démarrer la journée',
        'categoryId': 'matinal',
        'videoUrl': 'https://youtu.be/o_73FeXw3ZI?si=BhCmy1WKNBNSOBjy',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Pratiquez dès le réveil',
          'Respirez profondément',
          'Étirez-vous en douceur',
        ],
        'duration': '20 min',
        'level': 'Tous niveaux',
      },
      // Vidéos de yoga prénatal
      {
        'id': '7',
        'title': 'Yoga Prénatal - Douceur et Bien-être',
        'description': 'Séance adaptée aux futures mamans',
        'categoryId': 'prenatal',
        'videoUrl': 'https://youtu.be/YW32CVi5mzM?feature=shared',
        'thumbnail': defaultThumbnail,
        'instructions': [
          'Adaptez les postures à votre confort',
          'Respirez calmement',
          'Écoutez votre corps',
        ],
        'duration': '25 min',
        'level': 'Adapté grossesse',
      },
    ];

    return Stream.value(
      courses
          .where((course) => course['categoryId'] == categoryId)
          .map((data) => YogaCourse.fromMap(data))
          .toList(),
    );
  }

  Future<void> initializeData() async {
    // Cette méthode n'est plus nécessaire car nous utilisons des données statiques
    return;
  }
}
