import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';

class StudentHomeworkScreen extends StatelessWidget {
  const StudentHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final DatabaseService dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homework & Assignments'),
      ),
      body: StreamBuilder<List<Assignment>>(
        stream: dbService.streamAssignments(targetClass: '10A'), // Hardcoded to student's class
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final assignments = snapshot.data ?? [];
          // Client-side sorting: newest first
          assignments.sort((a, b) => b.postedDate.compareTo(a.postedDate));

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
              return AssignmentItem(assignment: assignment, isDark: isDark);
            },
          );
        },
      ),
    );
  }
}

class AssignmentItem extends StatefulWidget {
  final Assignment assignment;
  final bool isDark;
  const AssignmentItem({super.key, required this.assignment, required this.isDark});

  @override
  State<AssignmentItem> createState() => _AssignmentItemState();
}

class _AssignmentItemState extends State<AssignmentItem> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final isOverdue = widget.assignment.dueDate.isBefore(DateTime.now());

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
                    widget.assignment.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: _isCompleted ? TextDecoration.lineThrough : null,
                      color: widget.isDark ? Colors.white : AppColors.navy,
                    ),
                  ),
                ),
                Chip(
                  label: Text(_isCompleted ? 'Done' : (isOverdue ? 'Overdue' : 'Active'), style: const TextStyle(color: Colors.white, fontSize: 12)),
                  backgroundColor: _isCompleted ? Colors.blue : (isOverdue ? Colors.red : Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.assignment.description.isNotEmpty ? widget.assignment.description : 'No description provided.',
              style: TextStyle(fontSize: 14, color: widget.isDark ? Colors.grey[400] : Colors.grey[700]),
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
                      'Due: ${DateFormat('MMM dd, yyyy').format(widget.assignment.dueDate)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isOverdue ? Colors.red : Colors.blue,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Posted: ${DateFormat('MMM dd').format(widget.assignment.postedDate)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading attached files...')),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Files'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isCompleted = !_isCompleted;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_isCompleted ? 'Marked as completed' : 'Marked as active')),
                      );
                    },
                    icon: Icon(_isCompleted ? Icons.check_circle : Icons.circle_outlined),
                    label: Text(_isCompleted ? 'Undo' : 'Mark Done'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isCompleted ? Colors.grey : Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
