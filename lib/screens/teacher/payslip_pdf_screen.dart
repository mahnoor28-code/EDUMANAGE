import 'package:flutter/material.dart';

class PayslipPdfScreen extends StatelessWidget {
  final String month;
  final String amount;

  const PayslipPdfScreen({
    super.key,
    required this.month,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Payslip Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Printing PDF...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading PDF to device...')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800), // Max width for web/desktop
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school, size: 40, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 16),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('EduManage', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                              Text('Excellence in Education', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('PAYSLIP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 2)),
                          Text('For the month of $month', style: const TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                  const Divider(thickness: 2, height: 40, color: Colors.black12),
                  
                  // Employee Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailRow('Employee Name:', 'Teacher (T001)'),
                      _buildDetailRow('Department:', 'Mathematics'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailRow('Designation:', 'Senior Teacher'),
                      _buildDetailRow('Date of Joining:', '15 Aug 2020'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Earnings & Deductions Table
                  Table(
                    border: TableBorder.all(color: Colors.black12),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        children: [
                          _buildTableCell('Earnings', isHeader: true),
                          _buildTableCell('Amount', isHeader: true, alignRight: true),
                          _buildTableCell('Deductions', isHeader: true),
                          _buildTableCell('Amount', isHeader: true, alignRight: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('Basic Salary'),
                          _buildTableCell('Rs 50,000', alignRight: true),
                          _buildTableCell('Provident Fund'),
                          _buildTableCell('Rs 2,500', alignRight: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('House Rent Allowance'),
                          _buildTableCell('Rs 10,000', alignRight: true),
                          _buildTableCell('Professional Tax'),
                          _buildTableCell('Rs 500', alignRight: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('Transport Allowance'),
                          _buildTableCell('Rs 5,500', alignRight: true),
                          _buildTableCell('Income Tax'),
                          _buildTableCell('Rs 1,000', alignRight: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell('Medical Allowance'),
                          _buildTableCell('Rs 4,000', alignRight: true),
                          _buildTableCell('Other Deductions'),
                          _buildTableCell('Rs 0', alignRight: true),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey.shade50),
                        children: [
                          _buildTableCell('Gross Earnings', isHeader: true),
                          _buildTableCell('Rs 69,500', isHeader: true, alignRight: true),
                          _buildTableCell('Total Deductions', isHeader: true),
                          _buildTableCell('Rs 4,000', isHeader: true, alignRight: true),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Net Pay Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Net Pay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                        Text(amount, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Amount in words: Sixty-five thousand five hundred rupees only.', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
                  const SizedBox(height: 50),

                  // Signatures
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(width: 150, height: 1, color: Colors.black54),
                          const SizedBox(height: 8),
                          const Text('Employer Signature', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(width: 150, height: 1, color: Colors.black54),
                          const SizedBox(height: 8),
                          const Text('Employee Signature', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text('This is a computer-generated document. No signature is required.', style: TextStyle(fontSize: 12, color: Colors.black38)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(color: Colors.black87)),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool alignRight = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.black87 : Colors.black54,
        ),
      ),
    );
  }
}
