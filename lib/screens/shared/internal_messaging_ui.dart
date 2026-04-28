import 'package:flutter/material.dart';
import '../../theme.dart';

class InternalMessagingScreen extends StatefulWidget {
  const InternalMessagingScreen({Key? key}) : super(key: key);

  @override
  State<InternalMessagingScreen> createState() => _InternalMessagingScreenState();
}

class _InternalMessagingScreenState extends State<InternalMessagingScreen> {
  final List<String> _messages = [
    "Hello! Welcome to EduManage Support.",
    "How can we help you today?",
  ];
  final TextEditingController _msgController = TextEditingController();

  void _sendMessage() {
    if (_msgController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_msgController.text.trim());
        _msgController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isMe = index > 1; // First 2 are dummy received messages
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.coral : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                        bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      _messages[index],
                      style: TextStyle(color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black87)),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.coral,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
