import 'package:flutter/material.dart';

class ClassAnnouncementsScreen extends StatelessWidget {
  const ClassAnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Announcements')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('New Announcement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Select Class'),
              items: const [
                DropdownMenuItem(value: '10A', child: Text('Class 10A')),
                DropdownMenuItem(value: '10B', child: Text('Class 10B')),
                DropdownMenuItem(value: '11C', child: Text('Class 11C')),
              ],
              onChanged: (val) {},
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Message Body',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Announcement broadcasted successfully!')));
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Announcement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Recent Announcements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    child: ListTile(
                      title: Text('Math Assignment Due Tomorrow!'),
                      subtitle: Text('Sent to: Class 10A • 2 hrs ago'),
                      leading: Icon(Icons.campaign, color: Colors.amber),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Lab equipment reminder for Physics.'),
                      subtitle: Text('Sent to: Class 11C • Yesterday'),
                      leading: Icon(Icons.campaign, color: Colors.amber),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
