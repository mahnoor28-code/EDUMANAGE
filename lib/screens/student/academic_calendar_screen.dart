import 'package:flutter/material.dart';

class AcademicCalendarScreen extends StatelessWidget {
  const AcademicCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Calendar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildEventTile('Mid Term Exams', 'Oct 15 - Oct 22', Colors.red, isDark),
          _buildEventTile('Eid Holidays', 'Nov 1 - Nov 5', Colors.orange, isDark),
          _buildEventTile('Annual Sports Day', 'Dec 12', Colors.blue, isDark),
          _buildEventTile('Winter Break', 'Dec 25 - Jan 2', Colors.cyan, isDark),
          _buildEventTile('Final Exams', 'Mar 10 - Mar 20', Colors.purple, isDark),
        ],
      ),
    );
  }

  Widget _buildEventTile(String title, String date, Color color, bool isDark) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 10,
          color: color,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.event),
      ),
    );
  }
}
