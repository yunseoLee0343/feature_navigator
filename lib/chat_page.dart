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
  final List<Map<String, String>> _messages = [
    {
      'role': 'assistant',
      'content': '안녕하세요. Feature Navigator 도우미입니다. 무엇을 도와드릴까요?'
    }
  ];
  late GPTService _gptService;

  bool isStartClicked = false;
  bool isUserDeterminedPath = false;

  @override
  void initState() {
    super.initState();

    final settings = FeatureSettings();
    _gptService = GPTService(
        settings.aiApiKey ?? '', settings.gptModel ?? GPTModel.gpt4oMini);
  }

  void _sendMessage() async {
    if (!isStartClicked) {
      setState(() {
        isStartClicked = true;
      });

      return;
    }

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

  List<Widget> _getButtons(List<String> contents) {
    return !isStartClicked
        ? [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isStartClicked = true;
                  });
                },
                child: const Text("시작"))
          ]
        : contents.map((content) {
            return ElevatedButton(
              onPressed: () {
                _controller.text = content;
                _sendMessage();
                setState(() {
                  isUserDeterminedPath = true;
                });
              },
              child: Text(content),
            );
          }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final routeInfoProvider = RouteInfoProvider(routes: allRoutes);
    final List<String> buttonContents = routeInfoProvider
        .getRoutesInfo()
        .map((routeInfo) => routeInfo['name']!)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Chat'),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                print("message: $message");
                String extracted = '';
                String path = '';

                if (message['role'] == 'assistant') {
                  /*
                  int questionMarkIndex = message['content']!.indexOf('?');
                  path = message['content']!
                      .substring(questionMarkIndex + 1)
                      .trim();
                  */
                  final regExp = RegExp(r'찾으시는 기능이 (.*?) 맞으신가요\?');
                  final match = regExp.firstMatch(message['content']!);

                  if (match != null) {
                    extracted = match.group(1)?.trim() ?? '';
                    print("extracted: $extracted");
                    path = routeInfoProvider.getRoutePath(extracted);
                  } else {
                    print('No match found.');
                  }
                } else if (isUserDeterminedPath) {
                  path = message['content']!;
                  isUserDeterminedPath = false;
                }

                print('Extracted Path: $path');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(message['content']!),
                      subtitle: Text(message['role'] == 'user' ? 'You' : 'GPT'),
                      leading: message['role'] == 'assistant'
                          ? const Icon(Icons.smart_toy)
                          : null,
                      trailing: message['role'] == 'user'
                          ? const Icon(Icons.person)
                          : null,
                      onTap: path.isNotEmpty
                          ? () {
                              context.push(path);
                            }
                          : null,
                    ),
                    if (path.isNotEmpty && message['role'] == 'assistant')
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(path);
                          },
                          child: Text("$extracted로 이동하기"),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _getButtons(buttonContents),
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
