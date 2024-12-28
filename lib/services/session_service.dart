import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> cancelSession(String sessionId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('Utilisateur non connecté');
      }

      // Supprimer la séance de la collection des séances de l'utilisateur
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('sessions')
          .doc(sessionId)
          .delete();

      // Ajouter à l'historique des séances annulées
      await _firestore.collection('cancelled_sessions').add({
        'sessionId': sessionId,
        'userId': userId,
        'cancelledAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'annulation de la séance: $e');
    }
  }
}
