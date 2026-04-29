import 'package:flutter/material.dart';

class AttendanceViewScreen extends StatelessWidget {
  const AttendanceViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Attendance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: 0.85,
                    strokeWidth: 20,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                const Column(
                  children: [
                    Text('85%', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    Text('Present', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildStatRow('Total Classes', '120'),
            _buildStatRow('Classes Attended', '102'),
            _buildStatRow('Classes Missed', '18'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
