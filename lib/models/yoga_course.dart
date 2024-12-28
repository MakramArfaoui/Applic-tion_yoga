class YogaCourse {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String videoUrl;
  final List<String> instructions;
  final String duration;
  final String level;

  YogaCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.videoUrl,
    required this.instructions,
    required this.duration,
    required this.level,
  });

  factory YogaCourse.fromMap(Map<String, dynamic> map) {
    return YogaCourse(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      categoryId: map['categoryId'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      instructions: List<String>.from(map['instructions'] ?? []),
      duration: map['duration'] ?? '',
      level: map['level'] ?? '',
    );
  }
}
