import 'package:feature_navigator/gpt_model.dart';
import 'package:feature_navigator/gpt_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late GPTService _gptService;

  @override
  void initState() {
    super.initState();

    final settings = FeatureSettings();
    _gptService = GPTService(
        settings.aiApiKey ?? '', settings.gptModel ?? GPTModel.gpt4oMini);
  }

  void _sendMessage() async {
    final message = _controller.text;
    if (message.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
    });
    _controller.clear();

    try {
      final response = await _gptService.sendMessage(message);
      setState(() {
        _messages.add({'role': 'assistant', 'content': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'assistant',
          'content': 'Error: Could not fetch response from GPT. $e'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['content']!),
                  subtitle: Text(message['role'] == 'user' ? 'You' : 'GPT'),
                  leading: message['role'] == 'assistant'
                      ? const Icon(Icons.smart_toy)
                      : null,
                  trailing: message['role'] == 'user'
                      ? const Icon(Icons.person)
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
