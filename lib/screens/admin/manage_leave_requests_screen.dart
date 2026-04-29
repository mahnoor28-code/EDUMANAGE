import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/mock_data.dart';
import '../../models/leave_request_model.dart';
import '../../services/database_service.dart';
import '../../theme.dart';

class ManageLeaveRequestsScreen extends StatefulWidget {
  const ManageLeaveRequestsScreen({super.key});

  @override
  State<ManageLeaveRequestsScreen> createState() => _ManageLeaveRequestsScreenState();
}

class _ManageLeaveRequestsScreenState extends State<ManageLeaveRequestsScreen> with SingleTickerProviderStateMixin {
  final DatabaseService _dbService = DatabaseService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _updateStatus(String id, String status) async {
    try {
      await _dbService.updateLeaveRequestStatus(id, status);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request $status successfully'), backgroundColor: status == 'Approved' ? Colors.green : Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating request: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Widget _buildRequestsList(String role) {
    return StreamBuilder<List<LeaveRequestModel>>(
      stream: _dbService.streamLeaveRequests(role: role),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading requests'));
        }

        final requests = snapshot.data ?? [];

        if (requests.isEmpty) {
          return const Center(
            child: Text('No leave requests found.', style: TextStyle(color: Colors.grey, fontSize: 16)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final req = requests[index];
            final duration = req.endDate.difference(req.startDate).inDays + 1;
            final isPending = req.status == 'Pending';

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          req.userName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                        ),
                        Chip(
                          label: Text(req.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          backgroundColor: req.status == 'Approved' 
                            ? Colors.green 
                            : req.status == 'Rejected' ? Colors.red : Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Reason: ${req.reason}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${DateFormat('MMM dd, yyyy').format(req.startDate)} - ${DateFormat('MMM dd, yyyy').format(req.endDate)} ($duration days)',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Applied on: ${DateFormat('MMM dd, yyyy hh:mm a').format(req.appliedDate)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (isPending) ...[
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => _updateStatus(req.id, 'Rejected'),
                            icon: const Icon(Icons.close, color: Colors.red),
                            label: const Text('Reject', style: TextStyle(color: Colors.red)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () => _updateStatus(req.id, 'Approved'),
                            icon: const Icon(Icons.check),
                            label: const Text('Approve'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Leave Requests'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: AppColors.coral,
          tabs: const [
            Tab(text: 'Teachers'),
            Tab(text: 'Students'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsList('Teacher'),
          _buildRequestsList('Student'),
        ],
      ),
    );
  }
}
