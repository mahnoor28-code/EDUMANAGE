import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';

class UploadAssignmentScreen extends StatefulWidget {
  const UploadAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<UploadAssignmentScreen> createState() => _UploadAssignmentScreenState();
}

class _UploadAssignmentScreenState extends State<UploadAssignmentScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String? _selectedClass;
  bool _isUploading = false;
  final DatabaseService _dbService = DatabaseService();

  void _uploadAssignment() async {
    if (_titleController.text.isEmpty || _selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a class and enter a title.'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final assignment = Assignment(
        id: '',
        title: _titleController.text,
        description: _descController.text,
        targetClass: _selectedClass!,
        dueDate: DateTime.now().add(const Duration(days: 7)), // Default due date
        teacherId: 'T001', // Mock teacher ID
        postedDate: DateTime.now(),
      );

      await _dbService.addAssignment(assignment);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment Uploaded!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Assignment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Select Class & Subject', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Class',
              ),
              items: const [
                DropdownMenuItem(value: '10A', child: Text('Class 10A')),
                DropdownMenuItem(value: '10B', child: Text('Class 10B')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedClass = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Assignment Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Description / Instructions',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
                color: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.blue),
                  SizedBox(height: 8),
                  Text('Tap to attach file (PDF, DOCX)'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadAssignment,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _isUploading 
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Publish Assignment', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
