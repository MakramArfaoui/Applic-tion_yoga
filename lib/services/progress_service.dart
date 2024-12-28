import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_progress.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveProgress(UserProgress progress) async {
    await _firestore.collection('progress').add(progress.toMap());
  }

  Stream<List<UserProgress>> getUserProgress(String userId) {
    return _firestore
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .orderBy('completedDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserProgress.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<List<UserProgress>> getSessionProgress(String sessionId) async {
    final snapshot = await _firestore
        .collection('progress')
        .where('sessionId', isEqualTo: sessionId)
        .get();
    return snapshot.docs
        .map((doc) => UserProgress.fromMap(doc.data(), doc.id))
        .toList();
  }
}
