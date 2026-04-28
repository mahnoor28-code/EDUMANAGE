import 'package:flutter/material.dart';

class FeesPaymentScreen extends StatefulWidget {
  const FeesPaymentScreen({Key? key}) : super(key: key);

  @override
  State<FeesPaymentScreen> createState() => _FeesPaymentScreenState();
}

class _FeesPaymentScreenState extends State<FeesPaymentScreen> {
  bool _isPaid = false;

  void _showPaymentGateway() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Secure Payment Gateway', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(decoration: const InputDecoration(labelText: 'Card Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card))),
              const SizedBox(height: 15),
              Row(
                children: [
                   Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Expiry (MM/YY)', border: OutlineInputBorder()))),
                   const SizedBox(width: 15),
                   Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'CVV', border: OutlineInputBorder()))),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() { _isPaid = true; });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Successful!'), backgroundColor: Colors.green));
                  },
                  child: const Text('Confirm Payment - Rs 14,500'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: _isPaid ? Colors.green.shade50 : Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(_isPaid ? 'Amount Paid' : 'Total Due', style: const TextStyle(fontSize: 18, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Text('Rs 14,500', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: _isPaid ? Colors.green : Colors.indigo)),
                    const SizedBox(height: 5),
                    Text(_isPaid ? 'Payment Received' : 'Due Date: May 15, 2026', style: TextStyle(color: _isPaid ? Colors.green : Colors.redAccent)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Fee Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Card(
              child: Column(
                children: [
                  ListTile(title: Text('Tuition Fee'), trailing: Text('Rs 10,000')),
                  Divider(),
                  ListTile(title: Text('Transport Fee'), trailing: Text('Rs 2,500')),
                  Divider(),
                  ListTile(title: Text('Library Fee'), trailing: Text('Rs 1,000')),
                  Divider(),
                  ListTile(title: Text('Sports Fee'), trailing: Text('Rs 1,000')),
                ],
              ),
            ),
            const Spacer(),
            if (!_isPaid)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _showPaymentGateway,
                child: const Text('Pay Now', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            if (_isPaid)
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Text('All dues cleared!', style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
