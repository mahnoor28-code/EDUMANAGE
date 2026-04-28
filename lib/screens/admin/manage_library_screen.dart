import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';

class ManageLibraryScreen extends StatefulWidget {
  const ManageLibraryScreen({Key? key}) : super(key: key);

  @override
  State<ManageLibraryScreen> createState() => _ManageLibraryScreenState();
}

class _ManageLibraryScreenState extends State<ManageLibraryScreen> {
  final DatabaseService _dbService = DatabaseService();

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
                onPressed: () async {
                  if (titleController.text.isNotEmpty && isbnController.text.isNotEmpty) {
                    final newBook = Book(
                      id: '',
                      title: titleController.text,
                      isbn: isbnController.text,
                      status: 'Available',
                    );
                    await _dbService.addBook(newBook);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Added!')));
                  }
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
              child: StreamBuilder<List<Book>>(
                stream: _dbService.streamBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading inventory'));
                  }

                  final inventory = snapshot.data ?? [];

                  if (inventory.isEmpty) {
                    return const Center(child: Text('No books in inventory.'));
                  }

                  return ListView.builder(
                    itemCount: inventory.length,
                    itemBuilder: (context, index) {
                      final book = inventory[index];
                      bool oos = book.status == 'Out of Stock';
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.book, color: Colors.brown),
                          title: Text(book.title),
                          subtitle: Text('ISBN: ${book.isbn}'),
                          trailing: Chip(
                            label: Text(book.status, style: const TextStyle(color: Colors.white)),
                            backgroundColor: oos ? Colors.redAccent : Colors.greenAccent.shade700,
                          ),
                          onLongPress: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Book?'),
                                content: Text('Are you sure you want to remove "${book.title}"?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await _dbService.deleteBook(book.id);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book Removed')));
                            }
                          },
                        ),
                      );
                    },
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
