import 'package:flutter/material.dart';

class ExamScheduleScreen extends StatelessWidget {
  const ExamScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Schedule')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text('Upcoming Mid-Term Exams', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _ExamCard(subject: 'Mathematics', date: 'May 10, 2026', time: '09:00 AM - 11:00 AM', room: 'Room 101'),
          _ExamCard(subject: 'Physics', date: 'May 12, 2026', time: '10:00 AM - 12:00 PM', room: 'Lab 2'),
          _ExamCard(subject: 'Chemistry', date: 'May 15, 2026', time: '09:00 AM - 11:00 AM', room: 'Lab 1'),
          _ExamCard(subject: 'English Literature', date: 'May 18, 2026', time: '01:00 PM - 03:00 PM', room: 'Hall B'),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final String subject;
  final String date;
  final String time;
  final String room;

  const _ExamCard({required this.subject, required this.date, required this.time, required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(subject, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink)),
                Chip(label: Text(room), backgroundColor: Colors.pink.shade50),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(date, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 20),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
