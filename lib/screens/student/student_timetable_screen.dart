import 'package:flutter/material.dart';

class StudentTimetableScreen extends StatelessWidget {
  const StudentTimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> schedule = [
      {'time': '08:00 AM - 09:00 AM', 'subject': 'Mathematics'},
      {'time': '09:00 AM - 10:00 AM', 'subject': 'Science'},
      {'time': '10:00 AM - 10:30 AM', 'subject': 'Break'},
      {'time': '10:30 AM - 11:30 AM', 'subject': 'English'},
      {'time': '11:30 AM - 12:30 PM', 'subject': 'History'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Timetable (Today)')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final s = schedule[index];
          final isBreak = s['subject'] == 'Break';
          return Card(
            color: isBreak ? Colors.grey.shade200 : Colors.white,
            elevation: isBreak ? 0 : 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                isBreak ? Icons.free_breakfast : Icons.access_time, 
                color: isBreak ? Colors.grey : Colors.blue, 
                size: 30
              ),
              title: Text(s['subject']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isBreak ? 18 : 16)),
              subtitle: Text(s['time']!),
            ),
          );
        },
      ),
    );
  }
}
