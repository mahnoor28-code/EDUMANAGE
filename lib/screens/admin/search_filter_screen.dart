import 'package:flutter/material.dart';
import '../../models/mock_data.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({Key? key}) : super(key: key);

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  String _filterType = 'All'; // 'All', 'Students', 'Teachers'

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    List<dynamic> results = [];

    if (_filterType == 'All' || _filterType == 'Students') {
      results.addAll(MockData.students.where((student) {
        return student.name.toLowerCase().contains(lowerQuery) ||
               student.id.toLowerCase().contains(lowerQuery) ||
               student.rollNumber.toLowerCase().contains(lowerQuery);
      }));
    }

    if (_filterType == 'All' || _filterType == 'Teachers') {
      results.addAll(MockData.teachers.where((teacher) {
        return teacher.name.toLowerCase().contains(lowerQuery) ||
               teacher.id.toLowerCase().contains(lowerQuery) ||
               teacher.department.toLowerCase().contains(lowerQuery);
      }));
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _performSearch,
                    decoration: InputDecoration(
                      hintText: 'Search ID, Name, Roll No...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Students'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Teachers'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _searchResults.isEmpty 
                  ? const Center(child: Text('No results found. Start searching!'))
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        if (item is Student) {
                          return ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(item.name),
                            subtitle: Text('ID: ${item.id} | Grade: ${item.grade}'),
                            trailing: const Text('Student', style: TextStyle(color: Colors.blue)),
                          );
                        } else if (item is Teacher) {
                          return ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.co_present)),
                            title: Text(item.name),
                            subtitle: Text('ID: ${item.id} | Dept: ${item.department}'),
                            trailing: const Text('Teacher', style: TextStyle(color: Colors.orange)),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: _filterType == label,
      onSelected: (bool selected) {
        setState(() {
          _filterType = label;
          _performSearch(_searchController.text);
        });
      },
    );
  }
}
