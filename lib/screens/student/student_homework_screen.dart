import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';

class StudentHomeworkScreen extends StatelessWidget {
  const StudentHomeworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final DatabaseService _dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homework & Assignments'),
      ),
      body: StreamBuilder<List<Assignment>>(
        stream: _dbService.streamAssignments(targetClass: '10A'), // Hardcoded to student's class
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading assignments'));
          }

          final assignments = snapshot.data ?? [];

          if (assignments.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No assignments posted yet. Enjoy your free time!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              final isOverdue = assignment.dueDate.isBefore(DateTime.now());

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              assignment.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : AppColors.navy,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(isOverdue ? 'Overdue' : 'Active', style: const TextStyle(color: Colors.white, fontSize: 12)),
                            backgroundColor: isOverdue ? Colors.red : Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        assignment.description.isNotEmpty ? assignment.description : 'No description provided.',
                        style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[700]),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: isOverdue ? Colors.red : Colors.blue),
                              const SizedBox(width: 6),
                              Text(
                                'Due: ${DateFormat('MMM dd, yyyy').format(assignment.dueDate)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isOverdue ? Colors.red : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Posted: ${DateFormat('MMM dd').format(assignment.postedDate)}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Downloading attached files...')),
                            );
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download Attachments'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
