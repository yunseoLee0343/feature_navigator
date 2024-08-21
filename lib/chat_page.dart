import 'package:feature_navigator/gpt_model.dart';
import 'package:feature_navigator/gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'feature_route.dart';
import 'feature_router_provider.dart';

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
    final routeInfoProvider = RouteInfoProvider(routes: allRoutes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Chat'),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: routeInfoProvider.getRoutesInfo().map((routeInfo) {
                return SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.go(routeInfo['path']!);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.all(12.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        routeInfo['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                print(message);
                String path = '';

                if (message['role'] == 'assistant') {
                  int questionMarkIndex = message['content']!.indexOf('?');
                  path = message['content']!
                      .substring(questionMarkIndex + 1)
                      .trim();
                }

                print('Extracted Path: $path');

                return ListTile(
                  title: Text(message['content']!),
                  subtitle: Text(message['role'] == 'user' ? 'You' : 'GPT'),
                  leading: message['role'] == 'assistant'
                      ? const Icon(Icons.smart_toy)
                      : null,
                  trailing: message['role'] == 'user'
                      ? const Icon(Icons.person)
                      : null,
                  // If there's a path in the message, show a button
                  onTap: path != ''
                      ? () {
                          context.push(path);
                        }
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
