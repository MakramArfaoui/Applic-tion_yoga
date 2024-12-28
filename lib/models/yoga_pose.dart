class YogaPose {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String difficulty;
  final int durationInMinutes;
  final List<String> benefits;

  YogaPose({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.difficulty,
    required this.durationInMinutes,
    required this.benefits,
  });

  factory YogaPose.fromMap(Map<String, dynamic> map) {
    return YogaPose(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      difficulty: map['difficulty'] ?? 'Débutant',
      durationInMinutes: map['durationInMinutes'] ?? 5,
      benefits: List<String>.from(map['benefits'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'durationInMinutes': durationInMinutes,
      'benefits': benefits,
    };
  }
}
