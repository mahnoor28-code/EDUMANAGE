class TeacherModel {
  final String id;
  final String name;
  final String subject;
  final String department;

  TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.department,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> data, String id) {
    return TeacherModel(
      id: id,
      name: data['name'] ?? '',
      subject: data['subject'] ?? '',
      department: data['department'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subject': subject,
      'department': department,
    };
  }
}
