import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/mock_data.dart'; // contains Notice

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notices')),
      body: StreamBuilder<List<Notice>>(
        stream: DatabaseService().streamNotices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notices available"));
          }
          final notices = snapshot.data!;
          return ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];
              return ListTile(
                title: Text(notice.title),
                subtitle: Text(notice.content), // BUG FIX: notice.message -> notice.content
                trailing: Text(notice.date.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
