import 'package:flutter/material.dart';
import '../../theme.dart';

class DigitalIdCardScreen extends StatelessWidget {
  final String username;
  
  const DigitalIdCardScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital ID Card'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.adminGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'EDUMANAGE HIGH SCHOOL',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.coral,
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                username.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Student',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('ID Number', 'S001'),
                    const SizedBox(height: 10),
                    _buildInfoRow('Class', '10A'),
                    const SizedBox(height: 10),
                    _buildInfoRow('DOB', '15-Aug-2010'),
                    const SizedBox(height: 10),
                    _buildInfoRow('Emergency', '+91 9876543210'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
