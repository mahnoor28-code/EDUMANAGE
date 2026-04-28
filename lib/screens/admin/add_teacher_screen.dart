import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/teacher_model.dart';
import '../../services/database_service.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({Key? key}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TeacherModel> _teachers = []; // Dummy local list

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _deptController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  void _addTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newTeacher = TeacherModel(
          id: '', // Firebase generates ID
          name: _nameController.text,
          subject: _subjectController.text,
          department: _deptController.text,
        );

        await _dbService.addTeacher(newTeacher);

        _nameController.clear();
        _subjectController.clear();
        _deptController.clear();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Teacher Added Successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding teacher: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Teachers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Teacher Name',
                    controller: _nameController,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Subject Specialization',
                    controller: _subjectController,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Department',
                    controller: _deptController,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(text: 'Add Teacher', onPressed: _addTeacher),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Teacher Directory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<TeacherModel>>(
                stream: _dbService.streamTeachers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading teachers'));
                  }

                  final teachersList = snapshot.data ?? [];

                  if (teachersList.isEmpty) {
                    return const Center(child: Text('No teachers added yet.'));
                  }

                  return ListView.builder(
                    itemCount: teachersList.length,
                    itemBuilder: (context, index) {
                      final teacher = teachersList[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(teacher.name.isNotEmpty ? teacher.name[0] : '?', style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(teacher.name),
                          subtitle: Text('Subject: ${teacher.subject} | Dept: ${teacher.department}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Deletion not implemented yet.')),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
