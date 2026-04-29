import 'package:flutter/material.dart';

class NotificationPanelScreen extends StatelessWidget {
  const NotificationPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          _buildNotificationTile('System Update Scheduled', 'System will be down for maintenance at midnight.', Icons.settings, Colors.blue, isDark),
          _buildNotificationTile('Reminder: Fee Deadline', 'The term fee deadline is approaching on Oct 5th.', Icons.payment, Colors.red, isDark),
          const SizedBox(height: 20),
          const Text('Earlier', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          _buildNotificationTile('New Assignment Posted', 'Teacher posted: "Algebra Worksheet #4"', Icons.assignment, Colors.green, isDark),
          _buildNotificationTile('Attendance Alert', 'You have marked absent for 3 days consecutively.', Icons.warning, Colors.orange, isDark),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(String title, String body, IconData icon, Color color, bool isDark) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        subtitle: Text(body, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
