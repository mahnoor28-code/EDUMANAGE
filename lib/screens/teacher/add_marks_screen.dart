import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class AddMarksScreen extends StatefulWidget {
  const AddMarksScreen({Key? key}) : super(key: key);

  @override
  State<AddMarksScreen> createState() => _AddMarksScreenState();
}

class _AddMarksScreenState extends State<AddMarksScreen> {
  // Enhanced local data for dynamic grade calculation
  final List<Map<String, dynamic>> _students = [
    {'name': 'Alice Smith', 'roll': '101', 'marksController': TextEditingController()},
    {'name': 'Bob Johnson', 'roll': '102', 'marksController': TextEditingController()},
    {'name': 'Charlie Brown', 'roll': '103', 'marksController': TextEditingController()},
  ];

  @override
  void initState() {
    super.initState();
    for (var student in _students) {
      student['marksController'].addListener(() {
        setState(() {}); // Trigger rebuild to update grade dynamically
      });
    }
  }

  @override
  void dispose() {
    for (var student in _students) {
      student['marksController'].dispose();
    }
    super.dispose();
  }

  String _calculateGrade(String marksText) {
    if (marksText.isEmpty) return '-';
    final marks = int.tryParse(marksText);
    if (marks == null || marks < 0 || marks > 100) return 'Invalid';

    if (marks >= 90) return 'A+';
    if (marks >= 80) return 'A';
    if (marks >= 70) return 'B';
    if (marks >= 60) return 'C';
    if (marks >= 50) return 'D';
    return 'F';
  }

  Color _getGradeColor(String grade) {
    if (grade == 'A+' || grade == 'A') return Colors.green;
    if (grade == 'B' || grade == 'C') return Colors.blue;
    if (grade == 'D') return Colors.orange;
    if (grade == 'F') return Colors.red;
    return Colors.grey;
  }

  String _getPassFail(String marksText) {
    if (marksText.isEmpty) return '';
    final marks = int.tryParse(marksText);
    if (marks == null || marks < 0 || marks > 100) return '';
    return marks >= 50 ? 'PASS' : 'FAIL';
  }

  void _submitMarks() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Marks and Grades have been successfully recorded!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Marks (Mathematics)')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Marks: 100', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Passing Marks: 50', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                final grade = _calculateGrade(student['marksController'].text);
                final status = _getPassFail(student['marksController'].text);
                final gradeColor = _getGradeColor(grade);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              child: Text(student['roll']),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                student['name'], 
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: student['marksController'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Marks Obt.',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text('Grade: ', style: TextStyle(fontSize: 16, color: Colors.grey)),
                                    Text(
                                      grade,
                                      style: TextStyle(
                                        fontSize: 22, 
                                        fontWeight: FontWeight.bold, 
                                        color: gradeColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if (status.isNotEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: status == 'PASS' ? Colors.green.shade50 : Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: status == 'PASS' ? Colors.green : Colors.red),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: status == 'PASS' ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'SUBMIT ALL MARKS',
              onPressed: _submitMarks,
            ),
          )
        ],
      ),
    );
  }
}
