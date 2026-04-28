import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';
import '../../widgets/dashboard_card.dart';
import '../login_screen.dart';
import 'mark_attendance_screen.dart';
import 'add_marks_screen.dart';
import 'teacher_timetable_screen.dart';
import 'upload_assignment_screen.dart';
import 'student_performance_screen.dart';
import '../shared/leave_request_screen.dart';
import 'payroll_screen.dart';
import 'class_announcements_screen.dart';
import '../shared/feedback_screen.dart';
import '../shared/regulations_screen.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';
import 'package:intl/intl.dart';

class TeacherDashboard extends StatelessWidget {
  final String username;
  const TeacherDashboard({Key? key, this.username = 'Teacher'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  final provider = Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(!provider.isDarkMode);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.adminGradient,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: AppColors.navy),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, $username',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Mathematics Department',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : MediaQuery.of(context).size.width < 900 ? 3 : 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: MediaQuery.of(context).size.width < 400 ? 1.1 : 1.3,
                    children: [
                      DashboardCard(
                        title: 'Mark Attendance',
                        icon: Icons.fact_check,
                        color: Colors.green,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MarkAttendanceScreen())),
                      ),
                      DashboardCard(
                        title: 'Add Marks',
                        icon: Icons.format_list_numbered,
                        color: Colors.orange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMarksScreen())),
                      ),
                      DashboardCard(
                        title: 'Upload Assignments',
                        icon: Icons.upload_file,
                        color: Colors.blue,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadAssignmentScreen())),
                      ),
                      DashboardCard(
                        title: 'Student Performance',
                        icon: Icons.bar_chart,
                        color: Colors.purple,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentPerformanceScreen())),
                      ),
                      DashboardCard(
                        title: 'My Timetable',
                        icon: Icons.calendar_today,
                        color: AppColors.coral,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TeacherTimetableScreen())),
                      ),
                      DashboardCard(
                        title: 'Leave Request',
                        icon: Icons.event_busy,
                        color: Colors.redAccent,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestScreen(userId: 'T001', userName: 'Teacher', userRole: 'Teacher'))),
                      ),
                      DashboardCard(
                        title: 'Payroll Details',
                        icon: Icons.payments,
                        color: Colors.teal,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PayrollScreen())),
                      ),
                      DashboardCard(
                        title: 'Class Announcements',
                        icon: Icons.campaign,
                        color: Colors.amber,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClassAnnouncementsScreen())),
                      ),
                      DashboardCard(
                        title: 'Feedback',
                        icon: Icons.feedback,
                        color: Colors.blueGrey,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen(userRole: 'Teacher', userId: 'T001'))),
                      ),
                      DashboardCard(
                        title: 'Regulations',
                        icon: Icons.rule,
                        color: Colors.deepOrange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegulationsScreen(isAdmin: false, targetRole: 'Teacher'))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Recent Leave Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
                  const SizedBox(height: 10),
                  StreamBuilder<List<LeaveRequest>>(
                    stream: DatabaseService().streamLeaveRequests(userId: 'T001'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error loading requests'));
                      }
                      final requests = snapshot.data ?? [];
                      if (requests.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No recent leave requests.', style: TextStyle(color: Colors.grey)),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requests.length > 3 ? 3 : requests.length,
                        itemBuilder: (context, index) {
                          final req = requests[index];
                          final duration = req.endDate.difference(req.startDate).inDays + 1;
                          Color statusColor = Colors.orange;
                          if (req.status == 'Approved') statusColor = Colors.green;
                          if (req.status == 'Rejected') statusColor = Colors.red;

                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(req.reason, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${DateFormat('MMM dd').format(req.startDate)} - ${DateFormat('MMM dd, yyyy').format(req.endDate)} ($duration days)'),
                              trailing: Chip(
                                label: Text(req.status, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                backgroundColor: statusColor,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
