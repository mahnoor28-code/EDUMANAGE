import 'package:flutter/material.dart';
import 'admin/admin_dashboard.dart';
import 'teacher/teacher_dashboard.dart';
import 'student/student_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  final String username;
  
  const RoleSelectionScreen({Key? key, required this.username}) : super(key: key);

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027), // Deep dark
              Color(0xFF203A43), // Slightly lighter
              Color(0xFF2C5364), // Ocean blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('Select Your Role', style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose your profile to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 50),
                      _buildRoleCard(
                        context,
                        title: 'Administrator',
                        subtitle: 'Manage the entire school system',
                        icon: Icons.admin_panel_settings_rounded,
                        color: Colors.redAccent,
                        onTap: () => _navigateTo(context, AdminDashboard(username: username)),
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        context,
                        title: 'Teacher',
                        subtitle: 'Access classes and manage students',
                        icon: Icons.person_rounded,
                        color: Colors.blueAccent,
                        onTap: () => _navigateTo(context, TeacherDashboard(username: username)),
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        context,
                        title: 'Student',
                        subtitle: 'View grades, attendance, and more',
                        icon: Icons.school_rounded,
                        color: Colors.green,
                        onTap: () => _navigateTo(context, StudentDashboard(username: username)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        highlightColor: color.withOpacity(0.1),
        splashColor: color.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.white.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
