import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notices = [
      {'title': 'Annual Sports Day', 'date': 'Today', 'content': 'The Annual Sports Day will be held on 25th Oct. Students are requested to register.'},
      {'title': 'Exam Schedule Released', 'date': '2 days ago', 'content': 'Mid-term exam schedule for all classes is now available on the portal.'},
      {'title': 'Holiday Notice', 'date': '1 week ago', 'content': 'School will remain closed on Friday due to local elections.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notices'), automaticallyImplyLeading: false),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(notice['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      Text(notice['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(notice['content']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
