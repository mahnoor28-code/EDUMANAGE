import 'package:flutter/material.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';
import '../../services/database_service.dart';

class FeedbackScreen extends StatefulWidget {
  final String userRole; // e.g., 'Student', 'Teacher', 'Admin'
  final String userId;

  const FeedbackScreen({super.key, required this.userRole, required this.userId});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _typeController = TextEditingController(text: 'Suggestion');
  final DatabaseService _dbService = DatabaseService();

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final newFeedback = FeedbackItem(
          id: '', // Firestore uses auto-id
          text: _textController.text,
          submittedBy: widget.userId,
          date: DateTime.now(),
          type: _typeController.text,
      );
      
      await _dbService.addFeedback(newFeedback);
      
      if (mounted) {
        _textController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback Submitted Successfully!'), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback & Complaints'),
      ),
      body: widget.userRole == 'Admin' ? _buildFeedbackList() : _buildStudentTeacherView(),
    );
  }

  Widget _buildStudentTeacherView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Submit New Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _typeController.text,
                      items: ['Suggestion', 'Complaint'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _typeController.text = newValue!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _textController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Details',
                        border: OutlineInputBorder(),
                        hintText: 'Describe your feedback or complaint here...',
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navy,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: _submitFeedback,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Your Past Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(child: _buildFeedbackList()),
        ],
      ),
    );
  }

  Widget _buildFeedbackList() {
    return StreamBuilder<List<FeedbackItem>>(
      stream: _dbService.streamFeedbacks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        List<FeedbackItem> feedbacks = snapshot.data ?? [];
        if (widget.userRole != 'Admin') {
          feedbacks = feedbacks.where((f) => f.submittedBy == widget.userId).toList();
        }

        if (feedbacks.isEmpty) {
          return const Center(child: Text('No feedback entries found.'));
        }

        return ListView.builder(
          itemCount: feedbacks.length,
          itemBuilder: (context, index) {
            final f = feedbacks[index];
            final isComplaint = f.type == 'Complaint';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  isComplaint ? Icons.warning_rounded : Icons.lightbulb,
                  color: isComplaint ? Colors.redAccent : Colors.orangeAccent,
                  size: 32,
                ),
                title: Text(f.text),
                subtitle: Text('By: ${f.submittedBy} • ${_formatDate(f.date)}'),
                trailing: Chip(
                  label: Text(f.type, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  backgroundColor: isComplaint ? Colors.red : Colors.green,
                ),
              ),
            );
          },
        );
      }
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

