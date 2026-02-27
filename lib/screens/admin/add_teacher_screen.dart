import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/teacher_model.dart';

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

  void _addTeacher() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _teachers.add(TeacherModel(
          id: DateTime.now().toString(),
          name: _nameController.text,
          subject: _subjectController.text,
          department: _deptController.text,
        ));
      });
      _nameController.clear();
      _subjectController.clear();
      _deptController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher Added Successfully!')),
      );
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
              child: _teachers.isEmpty 
                  ? const Center(child: Text('No teachers added yet.'))
                  : ListView.builder(
                      itemCount: _teachers.length,
                      itemBuilder: (context, index) {
                        final teacher = _teachers[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text(teacher.name[0], style: const TextStyle(color: Colors.white)),
                            ),
                            title: Text(teacher.name),
                            subtitle: Text('Subject: ${teacher.subject} | Dept: ${teacher.department}'),
                          ),
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
