import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/student_model.dart';

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

  void _addStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _students.add(StudentModel(
          id: DateTime.now().toString(),
          name: _nameController.text,
          rollNumber: _rollNoController.text,
          currentClass: _classController.text,
        ));
      });
      _nameController.clear();
      _rollNoController.clear();
      _classController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student Added Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Students')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            Expanded(
              child: _students.isEmpty 
                  ? const Center(child: Text('No students added yet.'))
                  : ListView.builder(
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        final student = _students[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(student.name[0])),
                            title: Text(student.name),
                            subtitle: Text('Class: ${student.currentClass} | Roll: ${student.rollNumber}'),
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
