class Regulation {
  final String id;
  final String title;
  final String description;
  final String targetRole;

  Regulation({required this.id, required this.title, required this.description, required this.targetRole});

  factory Regulation.fromMap(Map<String, dynamic> data, String id) {
    return Regulation(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      targetRole: data['targetRole'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'targetRole': targetRole,
    };
  }
}
