import 'package:flutter/material.dart';
import '../../models/mock_data.dart';
import '../../theme.dart';
import '../../services/database_service.dart';

class RegulationsScreen extends StatefulWidget {
  final bool isAdmin;
  final String targetRole; // e.g., 'Student', 'Teacher', or 'All'

  const RegulationsScreen({super.key, this.isAdmin = false, this.targetRole = 'All'});

  @override
  State<RegulationsScreen> createState() => _RegulationsScreenState();
}

class _RegulationsScreenState extends State<RegulationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  void _addRegulation() async {
    if (_formKey.currentState!.validate()) {
      final newReg = Regulation(
        id: '', // Firestore will generate automatically
        title: _titleController.text,
        description: _descController.text,
        targetRole: widget.targetRole != 'All' ? widget.targetRole : 'Student',
      );
      
      await _dbService.addRegulation(newReg);

      _titleController.clear();
      _descController.clear();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Regulation Added!')));
      }
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add ${widget.targetRole != 'All' ? widget.targetRole : ''} Rule'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.navy, foregroundColor: Colors.white),
              onPressed: _addRegulation,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteRegulation(Regulation reg) async {
    await _dbService.deleteRegulation(reg.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.targetRole != 'All' ? '${widget.targetRole} Rules & Regulations' : 'Rules & Regulations'),
        actions: [
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddDialog,
            )
        ],
      ),
      body: StreamBuilder<List<Regulation>>(
        stream: _dbService.streamRegulations(widget.targetRole),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final filteredRules = snapshot.data ?? [];
          
          if (filteredRules.isEmpty) {
            return const Center(child: Text("No rules found."));
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredRules.length,
            itemBuilder: (context, index) {
              final rule = filteredRules[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: AppColors.navyLight.withOpacity(0.2))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${index + 1}. ${rule.title}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                            ),
                          ),
                          if (widget.isAdmin)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteRegulation(rule),
                            ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        rule.description,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                      if (widget.isAdmin && widget.targetRole == 'All') // Only show badge if mixed
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Applies to: ${rule.targetRole}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

