import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

// Enhanced local model for the UI prototype
class AttendanceStudent {
  final String id;
  final String name;
  final String rollNumber;
  String status; // 'Present', 'Absent', 'Leave'
  String leaveReason;

  AttendanceStudent({
    required this.id,
    required this.name,
    required this.rollNumber,
    this.status = 'Present',
    this.leaveReason = '',
  });
}

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final List<AttendanceStudent> _students = [
    AttendanceStudent(id: '1', name: 'Alice Smith', rollNumber: '101'),
    AttendanceStudent(id: '2', name: 'Bob Johnson', rollNumber: '102'),
    AttendanceStudent(id: '3', name: 'Charlie Brown', rollNumber: '103'),
    AttendanceStudent(id: '4', name: 'Diana Prince', rollNumber: '104'),
  ];

  void _submitAttendance() {
    int present = _students.where((s) => s.status == 'Present').length;
    int absent = _students.where((s) => s.status == 'Absent').length;
    int leave = _students.where((s) => s.status == 'Leave').length;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved! Present: $present, Absent: $absent, On Leave: $leave')),
    );
    Navigator.pop(context);
  }

  void _showLeaveReasonDialog(AttendanceStudent student) {
    final TextEditingController reasonController = TextEditingController(text: student.leaveReason);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reason for ${student.name}\'s Leave'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              hintText: 'Enter reason (e.g. Sick, Family)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  student.leaveReason = reasonController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mark Attendance - Class 10A')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              child: Text(student.rollNumber),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                student.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatusButton(student, 'Present', Colors.green),
                            _buildStatusButton(student, 'Absent', Colors.red),
                            _buildStatusButton(student, 'Leave', Colors.orange),
                          ],
                        ),
                        if (student.status == 'Leave')
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    student.leaveReason.isEmpty ? 'No reason provided' : 'Reason: ${student.leaveReason}',
                                    style: TextStyle(color: Colors.grey.shade700, fontStyle: FontStyle.italic),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                                  onPressed: () => _showLeaveReasonDialog(student),
                                  tooltip: 'Edit Leave Reason',
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'SUBMIT ATTENDANCE',
              onPressed: _submitAttendance,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusButton(AttendanceStudent student, String status, Color color) {
    final isSelected = student.status == status;
    return InkWell(
      onTap: () {
        setState(() {
          student.status = status;
          if (status != 'Leave') student.leaveReason = ''; // clear reason if not leave
        });
        if (status == 'Leave' && student.leaveReason.isEmpty) {
          _showLeaveReasonDialog(student);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
