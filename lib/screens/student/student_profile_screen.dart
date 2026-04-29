import 'package:flutter/material.dart';

class StudentProfileScreen extends StatelessWidget {
  final String username;
  const StudentProfileScreen({super.key, this.username = 'Student'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.amber,
            child: Text(
              username.isNotEmpty ? username[0].toUpperCase() : 'S', 
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(username.isNotEmpty ? username : 'Student', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Text('${username.toLowerCase().replaceAll(' ', '.')}@edumanage.com', style: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 30),
          const Divider(),
          _buildInfoTile(Icons.class_, 'Class', '10A'),
          _buildInfoTile(Icons.numbers, 'Roll Number', '101'),
          _buildInfoTile(Icons.cake, 'Date of Birth', '15 May 2008'),
          _buildInfoTile(Icons.phone, 'Guardian Contact', '+1 234 567 8900'),
          _buildInfoTile(Icons.home, 'Address', '123 Education St, Knowledge City'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
