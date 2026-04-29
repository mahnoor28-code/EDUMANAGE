import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart'; // Contains Notice model

class ManageNoticesScreen extends StatefulWidget {
  const ManageNoticesScreen({super.key});

  @override
  State<ManageNoticesScreen> createState() => _ManageNoticesScreenState();
}

class _ManageNoticesScreenState extends State<ManageNoticesScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  void _postNotice() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      final newNotice = Notice(
        id: '', 
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now(),
        postedBy: 'Admin',
      );
      
      await _dbService.addNotice(newNotice);
      
      if (mounted) {
        _titleController.clear();
        _contentController.clear();
        Navigator.pop(context);
      }
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
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notice Board')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoticeDialog,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Notice>>(
        stream: _dbService.streamNotices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final notices = snapshot.data ?? [];
          
          if (notices.isEmpty) {
             return const Center(child: Text('No notices found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];
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
                          Expanded(child: Text(notice.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          Text(_formatDate(notice.date), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(notice.content),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

