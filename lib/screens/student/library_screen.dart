import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<Map<String, String>> _availableBooks = [
    {'title': 'Introduction to Algorithms', 'status': 'Available'},
    {'title': 'Modern Physics', 'status': 'Available'},
    {'title': 'Organic Chemistry', 'status': 'Available'},
  ];

  final List<Map<String, String>> _issuedBooks = [
    {'title': 'Calculus Vol. 1', 'due': '24th April, 2026'},
  ];

  void _issueBook(int index) {
    setState(() {
      final book = _availableBooks[index];
      _issuedBooks.add({
        'title': book['title']!,
        'due': '14 days from now',
      });
      _availableBooks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Issued Successfully'), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search books...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Top Picks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._availableBooks.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, String> book = entry.value;
            return Card(
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.blue, size: 40),
                title: Text(book['title']!),
                subtitle: Text(book['status']!),
                trailing: ElevatedButton(
                  onPressed: () => _issueBook(idx),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  child: const Text('Issue'),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          const Text('Currently Issued', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._issuedBooks.map((book) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.assignment_turned_in, color: Colors.green, size: 40),
                title: Text(book['title']!),
                subtitle: Text('Due: ${book['due']}'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
