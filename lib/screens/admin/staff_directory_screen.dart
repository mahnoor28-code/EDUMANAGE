import 'package:flutter/material.dart';

class StaffDirectoryScreen extends StatefulWidget {
  const StaffDirectoryScreen({super.key});

  @override
  State<StaffDirectoryScreen> createState() => _StaffDirectoryScreenState();
}

class _StaffDirectoryScreenState extends State<StaffDirectoryScreen> {
  final List<Map<String, String>> _allStaff = [
    {'name': 'Ali', 'department': 'Mathematics Dept', 'phone': '+1 555-0101', 'role': 'Guard'},
    {'name': 'Kareem', 'department': 'Physics Dept', 'phone': '+1 555-0102', 'role': 'Attender'},
    {'name': 'Muneer', 'department': 'Administration', 'phone': '+1 555-0103', 'role': 'Clerk'},
    {'name': 'Akram', 'department': 'Chemistry Dept', 'phone': '+1 555-0104', 'role': 'Peon'},
  ];

  late List<Map<String, String>> _filteredStaff;

  @override
  void initState() {
    super.initState();
    _filteredStaff = _allStaff;
  }

  void _search(String query) {
    setState(() {
      _filteredStaff = _allStaff.where((staff) {
        return staff['name']!.toLowerCase().contains(query.toLowerCase()) || 
               staff['department']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff Directory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _search,
              decoration: const InputDecoration(
                labelText: 'Search Staff by Name or Dept',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _filteredStaff.length,
              itemBuilder: (context, index) {
                final staff = _filteredStaff[index];
                return _StaffCard(
                  name: staff['name']!,
                  department: staff['department']!,
                  phone: staff['phone']!,
                  role: staff['role']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffCard extends StatelessWidget {
  final String name;
  final String department;
  final String phone;
  final String role;

  const _StaffCard({required this.name, required this.department, required this.phone, required this.role});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  child: Text(name[0], style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(role, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Chip(label: Text(department, style: const TextStyle(fontSize: 10))),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.call), label: Text(phone)),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.email), label: const Text('Email')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
