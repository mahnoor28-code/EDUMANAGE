import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';
import 'package:intl/intl.dart';

class ClassAnnouncementsScreen extends StatefulWidget {
  const ClassAnnouncementsScreen({super.key});

  @override
  State<ClassAnnouncementsScreen> createState() => _ClassAnnouncementsScreenState();
}

class _ClassAnnouncementsScreenState extends State<ClassAnnouncementsScreen> {
  final _messageController = TextEditingController();
  final _titleController = TextEditingController();
  String? _selectedClass;
  final DatabaseService _dbService = DatabaseService();

  void _postAnnouncement() async {
    if (_titleController.text.isNotEmpty && _messageController.text.isNotEmpty && _selectedClass != null) {
      final newNotice = Notice(
        id: '',
        title: '[$_selectedClass] ${_titleController.text}',
        content: _messageController.text,
        date: DateTime.now(),
        postedBy: 'Teacher',
      );

      await _dbService.addNotice(newNotice);
      
      _titleController.clear();
      _messageController.clear();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Announcement broadcasted successfully!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    }
  }

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
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Announcement Title'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Select Class'),
              items: const [
                DropdownMenuItem(value: '10A', child: Text('Class 10A')),
                DropdownMenuItem(value: '10B', child: Text('Class 10B')),
                DropdownMenuItem(value: '11C', child: Text('Class 11C')),
              ],
              onChanged: (val) => setState(() => _selectedClass = val),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message Body',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _postAnnouncement,
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
              child: StreamBuilder<List<Notice>>(
                stream: _dbService.streamNotices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final notices = snapshot.data ?? [];
                  if (notices.isEmpty) {
                    return const Center(child: Text('No announcements yet.'));
                  }
                  return ListView.builder(
                    itemCount: notices.length,
                    itemBuilder: (context, index) {
                      final notice = notices[index];
                      return Card(
                        child: ListTile(
                          title: Text(notice.title),
                          subtitle: Text('${notice.content}\n${DateFormat('MMM dd, hh:mm a').format(notice.date)}'),
                          leading: const Icon(Icons.campaign, color: Colors.amber),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
