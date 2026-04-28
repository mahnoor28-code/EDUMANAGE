import 'package:flutter/material.dart';

class ManageLibraryScreen extends StatefulWidget {
  const ManageLibraryScreen({Key? key}) : super(key: key);

  @override
  State<ManageLibraryScreen> createState() => _ManageLibraryScreenState();
}

class _ManageLibraryScreenState extends State<ManageLibraryScreen> {
  final List<Map<String, String>> _inventory = [
    {'title': 'Calculus - James Stewart', 'isbn': '978-1285057095', 'status': '5 Available'},
    {'title': 'Artificial Intelligence', 'isbn': '978-0134610993', 'status': 'Out of Stock'},
    {'title': 'Data Structures in C++', 'isbn': '978-0131369082', 'status': '2 Available'},
  ];

  void _showAddBookModal() {
    final titleController = TextEditingController();
    final isbnController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add New Book', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Book Title')),
              const SizedBox(height: 10),
              TextField(controller: isbnController, decoration: const InputDecoration(labelText: 'ISBN')),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, foregroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    _inventory.insert(0, {
                      'title': titleController.text,
                      'isbn': isbnController.text,
                      'status': '1 Available',
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Added!')));
                },
                child: const Text('Add Book'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Library')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _showAddBookModal,
              icon: const Icon(Icons.add),
              label: const Text('Add New Book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Inventory',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Inventory Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _inventory.length,
                itemBuilder: (context, index) {
                  final book = _inventory[index];
                  bool oos = book['status'] == 'Out of Stock';
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.brown),
                      title: Text(book['title']!),
                      subtitle: Text('ISBN: ${book['isbn']}'),
                      trailing: Chip(
                        label: Text(book['status']!, style: const TextStyle(color: Colors.white)),
                        backgroundColor: oos ? Colors.redAccent : Colors.greenAccent.shade700,
                      ),
                      onLongPress: () {
                        setState(() {
                          _inventory.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Removed')));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
