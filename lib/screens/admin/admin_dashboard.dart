import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/dashboard_card.dart';
import '../../theme.dart';
import '../login_screen.dart';
import '../shared/notification_panel.dart';
import 'add_student_screen.dart';
import 'add_teacher_screen.dart';
import 'manage_notices_screen.dart';
import 'reports_screen.dart';
import 'search_filter_screen.dart';
import 'manage_fees_screen.dart';
import 'manage_library_screen.dart';
import 'staff_directory_screen.dart';
import '../shared/feedback_screen.dart';
import '../shared/regulations_screen.dart';
import 'manage_leave_requests_screen.dart';

class AdminDashboard extends StatelessWidget {
  final String username;
  const AdminDashboard({Key? key, this.username = 'Admin'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchFilterScreen()));
            },
          ),
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
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPanelScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.admin_panel_settings, size: 40, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Text(
                    'Administrator',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Student'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt_1),
              title: const Text('Add Teacher'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTeacherScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                    child: Icon(Icons.admin_panel_settings, size: 40, color: AppColors.navy),
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
                          'Administrator Portal',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : MediaQuery.of(context).size.width < 900 ? 3 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: MediaQuery.of(context).size.width < 400 ? 1.1 : 1.3,
              children: [
                DashboardCard(
                  title: 'Manage Students',
                  icon: Icons.people,
                  color: Colors.blue,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentScreen())),
                ),
                DashboardCard(
                  title: 'Manage Teachers',
                  icon: Icons.co_present,
                  color: Colors.orange,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTeacherScreen())),
                ),
                DashboardCard(
                  title: 'Notice Board',
                  icon: Icons.campaign,
                  color: Colors.purple,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageNoticesScreen())),
                ),
                DashboardCard(
                  title: 'Reports',
                  icon: Icons.bar_chart,
                  color: Colors.green,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
                ),
                DashboardCard(
                  title: 'Manage Fees',
                  icon: Icons.account_balance,
                  color: Colors.redAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFeesScreen())),
                ),
                DashboardCard(
                  title: 'Library System',
                  icon: Icons.library_books,
                  color: Colors.brown,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageLibraryScreen())),
                ),
                DashboardCard(
                  title: 'Staff Directory',
                  icon: Icons.contact_phone,
                  color: Colors.teal,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffDirectoryScreen())),
                ),
                DashboardCard(
                  title: 'View Feedbacks',
                  icon: Icons.feedback,
                  color: Colors.blueGrey,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen(userRole: 'Admin', userId: 'A001'))),
                ),
                DashboardCard(
                  title: 'Student Rules',
                  icon: Icons.rule,
                  color: Colors.deepOrange,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegulationsScreen(isAdmin: true, targetRole: 'Student'))),
                ),
                DashboardCard(
                  title: 'Teacher Rules',
                  icon: Icons.gavel,
                  color: Colors.indigo,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegulationsScreen(isAdmin: true, targetRole: 'Teacher'))),
                ),
                DashboardCard(
                  title: 'Leave Requests',
                  icon: Icons.event_busy,
                  color: Colors.pinkAccent,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageLeaveRequestsScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
