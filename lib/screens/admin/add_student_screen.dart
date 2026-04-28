import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/student_model.dart';
import '../../services/database_service.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<StudentModel> _students = []; // Dummy local list

  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _classController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  void _addStudent() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newStudent = StudentModel(
          id: '', // Firebase generates ID
          name: _nameController.text,
          rollNumber: _rollNoController.text,
          currentClass: _classController.text,
        );

        await _dbService.addStudent(newStudent);

        _nameController.clear();
        _rollNoController.clear();
        _classController.clear();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student Added Successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding student: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Students')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Student Name',
                    controller: _nameController,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Roll No',
                          controller: _rollNoController,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Class',
                          controller: _classController,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(text: 'Add Student', onPressed: _addStudent),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Recent Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            StreamBuilder<List<StudentModel>>(
              stream: _dbService.streamStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading students'));
                }

                final studentsList = snapshot.data ?? [];

                if (studentsList.isEmpty) {
                  return const Center(child: Text('No students added yet.'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: studentsList.length,
                  itemBuilder: (context, index) {
                    final student = studentsList[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text(student.name.isNotEmpty ? student.name[0] : '?')),
                        title: Text(student.name),
                        subtitle: Text('Class: ${student.currentClass} | Roll: ${student.rollNumber}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Student?'),
                                content: Text('Are you sure you want to remove "${student.name}"?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await _dbService.deleteStudent(student.id);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student Removed')));
                              }
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
