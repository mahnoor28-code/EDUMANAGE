import 'package:flutter/material.dart';

class ManageFeesScreen extends StatefulWidget {
  const ManageFeesScreen({super.key});

  @override
  State<ManageFeesScreen> createState() => _ManageFeesScreenState();
}

class _ManageFeesScreenState extends State<ManageFeesScreen> {
  final List<Map<String, String>> _transactions = [
    {'student': 'Mahzil Sohail', 'amount': 'Rs 14,500', 'status': 'Paid', 'date': 'Today, 10:30 AM'},
    {'student': 'Meerab Kashi', 'amount': 'Rs 8,000', 'status': 'Pending', 'date': 'Yesterday'},
    {'student': 'Malaika Asghar', 'amount': 'Rs 14,500', 'status': 'Paid', 'date': 'April 14, 2026'},
    {'student': 'Fatima Zafar', 'amount': 'Rs 4,500', 'status': 'Failed', 'date': 'April 12, 2026'},
  ];

  void _showAddTransactionModal() {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Record New Transaction', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Student Name')),
              const SizedBox(height: 10),
              TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (PKR)')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _transactions.insert(0, {
                      'student': nameController.text,
                      'amount': 'Rs ${amountController.text}',
                      'status': 'Paid',
                      'date': 'Just Now',
                    });
                  });
                  Navigator.pop(context);
                },
                child: const Text('Add Transaction'),
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
      appBar: AppBar(title: const Text('Manage Fees')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionModal,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.green.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.trending_up, color: Colors.green),
                          SizedBox(height: 5),
                          Text('Collected', style: TextStyle(color: Colors.black54)),
                          Text('Rs 450,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.red.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.red),
                          SizedBox(height: 5),
                          Text('Pending Dues', style: TextStyle(color: Colors.black54)),
                          Text('Rs 125,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            ..._transactions.map((tx) => _TransactionTile(
              student: tx['student']!,
              amount: tx['amount']!,
              status: tx['status']!,
              date: tx['date']!,
            )),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String student;
  final String amount;
  final String status;
  final String date;

  const _TransactionTile({required this.student, required this.amount, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.grey;
    if (status == 'Paid') statusColor = Colors.green;
    if (status == 'Pending') statusColor = Colors.orange;
    if (status == 'Failed') statusColor = Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Text(student[0])),
        title: Text(student),
        subtitle: Text(date),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
