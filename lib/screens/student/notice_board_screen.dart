import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart'; // contains Notice model

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseService dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(title: const Text('Notices'), automaticallyImplyLeading: false),
      body: StreamBuilder<List<Notice>>(
        stream: dbService.streamNotices(),
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

