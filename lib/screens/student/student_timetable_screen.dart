import 'package:flutter/material.dart';

class StudentTimetableScreen extends StatefulWidget {
  const StudentTimetableScreen({Key? key}) : super(key: key);

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  final List<Map<String, dynamic>> schedule = [
    {'time': '08:00 AM - 09:00 AM', 'subject': 'Mathematics', 'status': null},
    {'time': '09:00 AM - 10:00 AM', 'subject': 'Science', 'status': null},
    {'time': '10:00 AM - 10:30 AM', 'subject': 'Break', 'status': null},
    {'time': '10:30 AM - 11:30 AM', 'subject': 'English', 'status': null},
    {'time': '11:30 AM - 12:30 PM', 'subject': 'History', 'status': null},
  ];

  bool _isClassDone(String timeRange) {
    try {
      final parts = timeRange.split(' - ');
      if (parts.length < 2) return false;
      final endTimeStr = parts[1].trim(); // e.g., "09:00 AM"
      
      final timeParts = endTimeStr.split(' ');
      if (timeParts.length < 2) return false;
      
      final hm = timeParts[0].split(':');
      int hour = int.parse(hm[0]);
      final int minute = int.parse(hm[1]);
      final String amPm = timeParts[1].toUpperCase();

      if (amPm == 'PM' && hour != 12) {
        hour += 12;
      } else if (amPm == 'AM' && hour == 12) {
        hour = 0;
      }

      final now = DateTime.now();
      final classEndTime = DateTime(now.year, now.month, now.day, hour, minute);

      return now.isAfter(classEndTime);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Timetable (Today)')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final s = schedule[index];
          final isBreak = s['subject'] == 'Break';
          final isPast = !isBreak && _isClassDone(s['time'] as String);

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
              title: Text(s['subject'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isBreak ? 18 : 16)),
              subtitle: Text(s['time'] as String),
              trailing: isBreak 
                  ? null 
                  : DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: s['status'] as String?,
                        hint: const Text('Status'),
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                        items: [
                          DropdownMenuItem(
                            value: 'Done', 
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.green),
                              ),
                              child: const Text('Done', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            )
                          ),
                          DropdownMenuItem(
                            value: 'Missed', 
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red),
                              ),
                              child: const Text('Missed', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            )
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            s['status'] = val;
                          });
                        },
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
