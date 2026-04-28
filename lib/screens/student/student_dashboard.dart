import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';
import '../../widgets/dashboard_card.dart';
import '../login_screen.dart';
import 'attendance_view_screen.dart';
import 'results_view_screen.dart';
import 'student_timetable_screen.dart';
import 'notice_board_screen.dart';
import 'student_profile_screen.dart';
import 'academic_calendar_screen.dart';
import 'digital_id_card_screen.dart';
import 'library_screen.dart';
import 'fees_payment_screen.dart';
import 'exam_schedule_screen.dart';
import '../shared/feedback_screen.dart';
import '../shared/regulations_screen.dart';
import '../shared/leave_request_screen.dart';
import 'student_homework_screen.dart';
import '../../services/database_service.dart';
import '../../models/mock_data.dart';
import 'package:intl/intl.dart';

class StudentDashboard extends StatelessWidget {
  final String username;
  const StudentDashboard({Key? key, this.username = 'Student'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Portal'),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.navy,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : 'S',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.coral),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Class 10A | Roll No: 101',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text('Notices'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const NoticeBoardScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => StudentProfileScreen(username: username)));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.studentGradient,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Row(
                children: [
                   CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      username.isNotEmpty ? username[0].toUpperCase() : 'S', 
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.coral)
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $username!',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Class 10A | Roll No: 101',
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
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: MediaQuery.of(context).size.width < 400 ? 1.1 : 1.3,
                    children: [
                      DashboardCard(
                        title: 'My Attendance',
                        icon: Icons.pie_chart,
                        color: Colors.blue,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceViewScreen())),
                      ),
                      DashboardCard(
                        title: 'My Results',
                        icon: Icons.grade,
                        color: Colors.orange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultsViewScreen())),
                      ),
                      DashboardCard(
                        title: 'Timetable',
                        icon: Icons.schedule,
                        color: Colors.purple,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentTimetableScreen())),
                      ),
                      DashboardCard(
                        title: 'Academic Calendar',
                        icon: Icons.calendar_month,
                        color: Colors.teal,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AcademicCalendarScreen())),
                      ),
                      DashboardCard(
                        title: 'Digital ID Card',
                        icon: Icons.badge,
                        color: AppColors.coral,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DigitalIdCardScreen(username: 'Student',))),
                      ),
                      DashboardCard(
                        title: 'Library',
                        icon: Icons.local_library,
                        color: Colors.brown,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LibraryScreen())),
                      ),
                      DashboardCard(
                        title: 'Fees Payment',
                        icon: Icons.account_balance_wallet,
                        color: Colors.indigo,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeesPaymentScreen())),
                      ),
                      DashboardCard(
                        title: 'Exam Schedule',
                        icon: Icons.assignment,
                        color: Colors.pink,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExamScheduleScreen())),
                      ),
                      DashboardCard(
                        title: 'Feedback',
                        icon: Icons.feedback,
                        color: Colors.blueGrey,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen(userRole: 'Student', userId: 'S001'))),
                      ),
                      DashboardCard(
                        title: 'Regulations',
                        icon: Icons.rule,
                        color: Colors.deepOrange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegulationsScreen(isAdmin: false, targetRole: 'Student'))),
                      ),
                      DashboardCard(
                        title: 'Homework',
                        icon: Icons.book,
                        color: Colors.deepPurple,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentHomeworkScreen())),
                      ),
                      DashboardCard(
                        title: 'Leave Request',
                        icon: Icons.time_to_leave,
                        color: Colors.cyan,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestScreen(userId: 'S001', userName: 'Student', userRole: 'Student'))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Recent Leave Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
                  const SizedBox(height: 10),
                  StreamBuilder<List<LeaveRequest>>(
                    stream: DatabaseService().streamLeaveRequests(userId: 'S001'),
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
