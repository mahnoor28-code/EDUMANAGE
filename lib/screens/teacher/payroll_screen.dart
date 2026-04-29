import 'package:flutter/material.dart';
import 'payslip_pdf_screen.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final List<Map<String, String>> _payslips = [
    {'month': 'March 2026', 'amount': 'Rs 65,500', 'status': 'Paid'},
    {'month': 'February 2026', 'amount': 'Rs 65,500', 'status': 'Paid'},
    {'month': 'January 2026', 'amount': 'Rs 62,200', 'status': 'Paid'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payroll Details')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.teal.shade50,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Last Salary Credited', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
                  SizedBox(height: 8),
                  Text('Rs 65,500', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.teal)),
                  SizedBox(height: 8),
                  Text('April 2026', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Recent Payslips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._payslips.map((p) => _PayslipCard(month: p['month']!, amount: p['amount']!, status: p['status']!)),
        ],
      ),
    );
  }
}

class _PayslipCard extends StatelessWidget {
  final String month;
  final String amount;
  final String status;

  const _PayslipCard({required this.month, required this.amount, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.receipt, color: Colors.white)),
        title: Text(month, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Net Pay: $amount'),
        trailing: OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PayslipPdfScreen(month: month, amount: amount)),
            );
          },
          icon: const Icon(Icons.download, size: 16),
          label: const Text('PDF'),
        ),
      ),
    );
  }
}
