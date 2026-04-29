class LeaveRequestModel {
  final String id;
  final String userId;
  final String userName;
  final String userRole; // 'Student' or 'Teacher'
  final String reason;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'Pending', 'Approved', 'Rejected'
  final DateTime appliedDate;

  LeaveRequestModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.appliedDate,
  });

  factory LeaveRequestModel.fromMap(Map<String, dynamic> data, String id) {
    return LeaveRequestModel(
      id: id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userRole: data['userRole'] ?? '',
      reason: data['reason'] ?? '',
      startDate: data['startDate'] != null 
          ? (data['startDate'] is DateTime 
              ? data['startDate'] 
              : (data['startDate'] as dynamic).toDate()) 
          : DateTime.now(),
      endDate: data['endDate'] != null 
          ? (data['endDate'] is DateTime 
              ? data['endDate'] 
              : (data['endDate'] as dynamic).toDate()) 
          : DateTime.now(),
      status: data['status'] ?? 'Pending',
      appliedDate: data['appliedDate'] != null 
          ? (data['appliedDate'] is DateTime 
              ? data['appliedDate'] 
              : (data['appliedDate'] as dynamic).toDate()) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userRole': userRole,
      'reason': reason,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'appliedDate': appliedDate,
    };
  }
}
