import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ManageNoticesScreen extends StatefulWidget {
  const ManageNoticesScreen({Key? key}) : super(key: key);

  @override
  State<ManageNoticesScreen> createState() => _ManageNoticesScreenState();
}

class _ManageNoticesScreenState extends State<ManageNoticesScreen> {
  final List<Map<String, String>> _notices = [
    {'title': 'Annual Sports Day', 'date': '12 Oct 2024', 'content': 'The Annual Sports Day will be held on 25th Oct. Students are requested to register.'},
    {'title': 'Exam Schedule Released', 'date': '10 Oct 2024', 'content': 'Mid-term exam schedule for all classes is now available on the portal.'},
  ];

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _postNotice() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      setState(() {
        _notices.insert(0, {
          'title': _titleController.text,
          'date': 'Today',
          'content': _contentController.text,
        });
      });
      _titleController.clear();
      _contentController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddNoticeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Post New Notice'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hintText: 'Notice Title', controller: _titleController),
            const SizedBox(height: 10),
            CustomTextField(hintText: 'Notice Content', controller: _contentController),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: _postNotice, child: const Text('Post')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notice Board')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoticeDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notices.length,
        itemBuilder: (context, index) {
          final notice = _notices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(notice['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(notice['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(notice['content']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
