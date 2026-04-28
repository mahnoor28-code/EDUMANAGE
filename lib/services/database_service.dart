import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mock_data.dart'; // contains models like Regulation, Notice, Assignment
import '../models/student_model.dart';
import '../models/teacher_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Regulations ---
  
  Stream<List<Regulation>> streamRegulations(String role) {
    if (role == 'All') {
      return _db.collection('regulations').snapshots().map((snapshot) => 
        snapshot.docs.map((doc) => Regulation.fromMap(doc.data(), doc.id)).toList()
      );
    }
    return _db.collection('regulations')
      .where('targetRole', whereIn: [role, 'All'])
      .snapshots().map((snapshot) => 
        snapshot.docs.map((doc) => Regulation.fromMap(doc.data(), doc.id)).toList()
      );
  }

  Future<void> addRegulation(Regulation regulation) async {
    await _db.collection('regulations').add(regulation.toMap());
  }

  Future<void> deleteRegulation(String id) async {
    await _db.collection('regulations').doc(id).delete();
  }

  // --- Notices ---
  
  Stream<List<Notice>> streamNotices() {
    return _db.collection('notices')
      .orderBy('date', descending: true)
      .snapshots().map((snapshot) => 
        snapshot.docs.map((doc) => Notice.fromMap(doc.data(), doc.id)).toList()
      );
  }

  Future<void> addNotice(Notice notice) async {
    await _db.collection('notices').add(notice.toMap());
  }

  Future<void> deleteNotice(String id) async {
    await _db.collection('notices').doc(id).delete();
  }
  
  // --- Feedbacks ---

  Stream<List<FeedbackItem>> streamFeedbacks() {
    return _db.collection('feedbacks')
      .orderBy('date', descending: true)
      .snapshots().map((snapshot) => 
        snapshot.docs.map((doc) => FeedbackItem.fromMap(doc.data(), doc.id)).toList()
      );
  }

  Future<void> addFeedback(FeedbackItem feedback) async {
     await _db.collection('feedbacks').add(feedback.toMap());
  }

  // --- Leave Requests ---

  Stream<List<LeaveRequest>> streamLeaveRequests({String? userId, String? role}) {
    Query query = _db.collection('leave_requests').orderBy('appliedDate', descending: true);
    
    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    } else if (role != null) {
      query = query.where('userRole', isEqualTo: role);
    }
    
    return query.snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => LeaveRequest.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList()
    );
  }

  Future<void> addLeaveRequest(LeaveRequest request) async {
    await _db.collection('leave_requests').add(request.toMap());
  }

  Future<void> updateLeaveRequestStatus(String id, String status) async {
    await _db.collection('leave_requests').doc(id).update({'status': status});
  }

  // --- Assignments ---
  
  Stream<List<Assignment>> streamAssignments({String? targetClass}) {
    Query query = _db.collection('assignments').orderBy('postedDate', descending: true);
    if (targetClass != null) {
      query = query.where('targetClass', isEqualTo: targetClass);
    }
    return query.snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => Assignment.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList()
    );
  }

  Future<void> addAssignment(Assignment assignment) async {
    await _db.collection('assignments').add(assignment.toMap());
  }

  // --- Students ---
  
  Stream<List<StudentModel>> streamStudents() {
    return _db.collection('students').snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => StudentModel.fromMap(doc.data(), doc.id)).toList()
    );
  }

  Future<void> addStudent(StudentModel student) async {
    await _db.collection('students').add(student.toMap());
  }

  // --- Teachers ---

  Stream<List<TeacherModel>> streamTeachers() {
    return _db.collection('teachers').snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => TeacherModel.fromMap(doc.data(), doc.id)).toList()
    );
  }

  Future<void> addTeacher(TeacherModel teacher) async {
    await _db.collection('teachers').add(teacher.toMap());
  }
}
