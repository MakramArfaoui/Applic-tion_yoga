class YogaSession {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int duration;
  final String difficulty;
  final List<String> poses;

  YogaSession({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.difficulty,
    required this.poses,
  });

  factory YogaSession.fromMap(Map<String, dynamic> map, String id) {
    return YogaSession(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      duration: map['duration'] ?? 0,
      difficulty: map['difficulty'] ?? 'Débutant',
      poses: List<String>.from(map['poses'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'duration': duration,
      'difficulty': difficulty,
      'poses': poses,
    };
  }
}
