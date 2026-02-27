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
}
