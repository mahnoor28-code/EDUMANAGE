import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/mock_data.dart'; // contains FeedbackItem

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: StreamBuilder<List<FeedbackItem>>(
        stream: DatabaseService().streamFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No feedback yet"));
          }
          final feedbacks = snapshot.data!;
          return ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final fb = feedbacks[index];
              return ListTile(
                title: Text(fb.text), // BUG FIX: fb.message -> fb.text
                subtitle: Text("User: ${fb.submittedBy}"), // BUG FIX: fb.userId -> fb.submittedBy
                trailing: Text(fb.date.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
