import 'package:flutter/material.dart';

class TeacherTimetableScreen extends StatelessWidget {
  const TeacherTimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> schedule = [
      {'time': '08:00 AM - 09:00 AM', 'class': 'Class 10A', 'subject': 'Mathematics'},
      {'time': '09:00 AM - 10:00 AM', 'class': 'Class 9B', 'subject': 'Mathematics'},
      {'time': '10:00 AM - 11:00 AM', 'class': 'Class 11 Science', 'subject': 'Calculus'},
      {'time': '11:30 AM - 12:30 PM', 'class': 'Class 12 Science', 'subject': 'Advanced Math'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Timetable (Today)')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final s = schedule[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.access_time, color: Colors.blue, size: 30),
              title: Text(s['time']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${s['subject']} - ${s['class']}'),
            ),
          );
        },
      ),
    );
  }
}
