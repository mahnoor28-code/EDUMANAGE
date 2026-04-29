import 'regulation.dart';
export 'regulation.dart';

class Assignment {
  final String id;
  final String title;
  final String description;
  final String targetClass;
  final DateTime dueDate;
  final String teacherId;
  final DateTime postedDate;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.targetClass,
    required this.dueDate,
    required this.teacherId,
    required this.postedDate,
  });

  factory Assignment.fromMap(Map<String, dynamic> data, String id) {
    return Assignment(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      targetClass: data['targetClass'] ?? '',
      dueDate: data['dueDate'] != null ? (data['dueDate'] is DateTime ? data['dueDate'] : (data['dueDate'] as dynamic).toDate()) : DateTime.now(),
      teacherId: data['teacherId'] ?? '',
      postedDate: data['postedDate'] != null ? (data['postedDate'] is DateTime ? data['postedDate'] : (data['postedDate'] as dynamic).toDate()) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'targetClass': targetClass,
      'dueDate': dueDate,
      'teacherId': teacherId,
      'postedDate': postedDate,
    };
  }
}

class Student {
  final String id;
  final String name;
  final String grade; // e.g., '10A'
  final String rollNumber;
  double attendancePercentage;

  Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.rollNumber,
    this.attendancePercentage = 0.0,
  });

  factory Student.fromMap(Map<String, dynamic> data, String id) {
    return Student(
      id: id,
      name: data['name'] ?? '',
      grade: data['grade'] ?? '',
      rollNumber: data['rollNumber'] ?? '',
      attendancePercentage: (data['attendancePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade': grade,
      'rollNumber': rollNumber,
      'attendancePercentage': attendancePercentage,
    };
  }
}

class Teacher {
  final String id;
  final String name;
  final String department;

  Teacher({
    required this.id,
    required this.name,
    required this.department,
  });

  factory Teacher.fromMap(Map<String, dynamic> data, String id) {
    return Teacher(
      id: id,
      name: data['name'] ?? '',
      department: data['department'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'department': department,
    };
  }
}

class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String postedBy;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.postedBy,
  });

  factory Notice.fromMap(Map<String, dynamic> data, String id) {
    return Notice(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: data['date'] != null ? (data['date'] is DateTime ? data['date'] : (data['date'] as dynamic).toDate()) : DateTime.now(),
      postedBy: data['postedBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'postedBy': postedBy,
    };
  }
}

class FeedbackItem {
  final String id;
  final String text;
  final String submittedBy;
  final DateTime date;
  final String type; // 'Complaint' or 'Suggestion'

  FeedbackItem({
    required this.id,
    required this.text,
    required this.submittedBy,
    required this.date,
    required this.type,
  });

  factory FeedbackItem.fromMap(Map<String, dynamic> data, String id) {
    return FeedbackItem(
      id: id,
      text: data['text'] ?? '',
      submittedBy: data['submittedBy'] ?? '',
      date: data['date'] != null ? (data['date'] is DateTime ? data['date'] : (data['date'] as dynamic).toDate()) : DateTime.now(),
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'submittedBy': submittedBy,
      'date': date,
      'type': type,
    };
  }
}


class Book {
  final String id;
  final String title;
  final String isbn;
  final String status;

  Book({required this.id, required this.title, required this.isbn, required this.status});

  factory Book.fromMap(Map<String, dynamic> data, String id) {
    return Book(
      id: id,
      title: data['title'] ?? '',
      isbn: data['isbn'] ?? '',
      status: data['status'] ?? 'Available',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isbn': isbn,
      'status': status,
    };
  }
}

class MockData {
  static List<Student> students = [
    Student(id: 'S001', name: 'Maryam', grade: '10A', rollNumber: '101', attendancePercentage: 85.0),
    Student(id: 'S002', name: 'Fatima', grade: '10A', rollNumber: '102', attendancePercentage: 92.5),
    Student(id: 'S003', name: 'Malaika', grade: '10A', rollNumber: '103', attendancePercentage: 78.0),
    Student(id: 'S004', name: 'Mahzil', grade: '10B', rollNumber: '201', attendancePercentage: 90.0),
  ];

  static List<Teacher> teachers = [
    Teacher(id: 'T001', name: 'Mam Iram', department: 'Business process'),
    Teacher(id: 'T002', name: 'Mrs. Danial', department: 'Science'),
    Teacher(id: 'T003', name: 'Ms. Tanveer', department: 'English'),
  ];

  static List<Notice> notices = [
    Notice(
      id: 'N001',
      title: 'Exam Schedule Announced',
      content: 'Final term exams will begin on the 15th of next month. Please check the portal for the detailed schedule.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      postedBy: 'Admin',
    ),
    Notice(
      id: 'N002',
      title: 'School Sports Day',
      content: 'Annual sports day will be held this Friday. All students are encouraged to participate in at least one event.',
      date: DateTime.now().subtract(const Duration(days: 5)),
      postedBy: 'Admin',
    ),
  ];

  static List<Regulation> regulations = [
    Regulation(
      id: 'R001',
      title: 'Uniform Policy',
      description: 'All students must wear the approved school uniform. Navy blue blazer with school crest, proper tie, and formal black shoes.',
      targetRole: 'Student',
    ),
    Regulation(
      id: 'R002',
      title: 'Attendance Rule',
      description: 'A minimum of 75% attendance is required to be eligible for final exams.',
      targetRole: 'Student',
    ),
    Regulation(
      id: 'R003',
      title: 'Library Etiquette',
      description: 'Strict silence must be maintained in the library. Books must be returned within 14 days of issue.',
      targetRole: 'All',
    ),
    Regulation(
      id: 'R004',
      title: 'Teacher Code of Conduct',
      description: 'All teachers must maintain a professional demeanor and uphold the standard of teaching.',
      targetRole: 'Teacher',
    ),
  ];

  static List<FeedbackItem> feedbacks = [
    FeedbackItem(
      id: 'F001',
      text: 'The new library books are great, can we get more sci-fi?',
      submittedBy: 'S001',
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: 'Suggestion',
    ),
    FeedbackItem(
      id: 'F002',
      text: 'Water cooler on the 2nd floor is not working properly.',
      submittedBy: 'T002',
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: 'Complaint',
    ),
  ];
}
