class StudentModel {
  final String id;
  final String name;
  final String rollNumber;
  final String currentClass;
  bool isPresent; // For attendance tracking

  StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.currentClass,
    this.isPresent = false,
  });

  factory StudentModel.fromMap(Map<String, dynamic> data, String id) {
    return StudentModel(
      id: id,
      name: data['name'] ?? '',
      rollNumber: data['rollNumber'] ?? '',
      currentClass: data['currentClass'] ?? '',
      isPresent: data['isPresent'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNumber': rollNumber,
      'currentClass': currentClass,
      'isPresent': isPresent,
    };
  }
}
