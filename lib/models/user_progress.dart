class UserProgress {
  final String id;
  final String userId;
  final String sessionId;
  final DateTime completedDate;
  final int duration;
  final String notes;
  final int rating;

  UserProgress({
    required this.id,
    required this.userId,
    required this.sessionId,
    required this.completedDate,
    required this.duration,
    this.notes = '',
    this.rating = 0,
  });

  factory UserProgress.fromMap(Map<String, dynamic> map, String id) {
    return UserProgress(
      id: id,
      userId: map['userId'] ?? '',
      sessionId: map['sessionId'] ?? '',
      completedDate: DateTime.parse(map['completedDate']),
      duration: map['duration'] ?? 0,
      notes: map['notes'] ?? '',
      rating: map['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'sessionId': sessionId,
      'completedDate': completedDate.toIso8601String(),
      'duration': duration,
      'notes': notes,
      'rating': rating,
    };
  }
}
