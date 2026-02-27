import 'package:flutter/material.dart';

class ResultsViewScreen extends StatelessWidget {
  const ResultsViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> grades = [
      {'subject': 'Mathematics', 'grade': 'A', 'marks': '92/100'},
      {'subject': 'Science', 'grade': 'A+', 'marks': '95/100'},
      {'subject': 'English', 'grade': 'B+', 'marks': '80/100'},
      {'subject': 'History', 'grade': 'A', 'marks': '88/100'},
      {'subject': 'Geography', 'grade': 'B', 'marks': '75/100'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Results (Mid-Term)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Overall Grade: A', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('86%', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: grades.length,
                itemBuilder: (context, index) {
                  final item = grades[index];
                  return Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(item['subject']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item['marks']!, style: const TextStyle(fontSize: 16)),
                          Text('Grade: ${item['grade']}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
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
