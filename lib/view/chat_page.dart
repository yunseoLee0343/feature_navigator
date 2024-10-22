import 'package:feature_navigator/component/custom_button.dart';
import 'package:feature_navigator/model/gpt_model.dart';
import 'package:feature_navigator/model/utils.dart';
import 'package:feature_navigator/provider/gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../provider/feature_router_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  late GPTService _gptService;
  late AnimationController _animationController;
  ChattingState _chatPageState = ChattingState.initial;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    final settings = FeatureSettings();
    _gptService = GPTService(
      settings.aiApiKey ?? '',
      settings.gptModel ?? GPTModel.gpt4oMini,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setChattingState(ChattingState.listView);
      _addMessage('assistant',
          'Hello! I\'m an assistant that helps you find the features you want. If you have any questions about features, please ask me.');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _setTyping(bool typing) {
    setState(() => _isTyping = typing);
  }

  void _setChattingState(ChattingState state) {
    setState(() => _chatPageState = state);
  }

  void _sendMessage() async {
    final message = _controller.text;
    if (message.isEmpty) return;

    final String currentRoute = GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .last
        .route
        .name
        .toString();

    _addMessage('user', message);
    _controller.clear();
    _setTyping(true);
    await Future.delayed(const Duration(seconds: 1));

    switch (message) {
      case 'What can you do?':
        _addMessage('assistant',
            'I listen to your questions and help navigate to the appropriate screen. Also, I provide information about any parts of the screen you don\'t know.');
        break;
      case 'Explain the previous screen':
        _addMessage('assistant',
            'The current screen is ${RouteDataProvider.getRouteDescription(currentRoute)}');
        break;
      case 'Show me the screens I recently searched':
        _addMessage('assistant',
            'Here are the screens you recently searched. Is there any screen you want to go back to?');
        break;
      default:
        try {
          final response = await _gptService.sendMessage(message);
          _addMessage('assistant', response);
        } catch (e) {
          _addMessage(
              'assistant', 'Error: Could not fetch response from GPT. $e');
        }
        break;
    }
    _setTyping(false);
    if (message != 'Show me the list of screens') {
      _setChattingState(ChattingState.detailView);
    }
  }

  void _addMessage(String role, String content) {
    setState(() {
      _messages.add({'role': role, 'content': content});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  List<Widget> _buildActionButtons() {
    final initialButtonContents = [
      'What can you do?',
      'Explain the previous screen',
      'Show me the screens I recently searched'
    ];

    switch (_chatPageState) {
      case ChattingState.initial:
        return [
          CustomBlueButton(
            onPressed: () {
              _addMessage('user', 'Start');
              _setChattingState(ChattingState.listView);
            },
            text: "Start",
          ),
        ];
      case ChattingState.listView:
        return initialButtonContents
            .map((content) => CustomBlueButton(
                  onPressed: () {
                    _controller.text = content;
                    _sendMessage();
                  },
                  text: content,
                ))
            .toList();
      case ChattingState.detailView:
        return [
          CustomBlueButton(
            onPressed: () {
              _setChattingState(ChattingState.listView);
            },
            text: "Go back to the beginning",
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Chat'),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.white,
      endDrawer: _buildEndDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildMessageList()),
          if (_isTyping) _buildTypingIndicator(),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _buildActionButtons(),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              double scale = 1.0 +
                  0.3 *
                      (1.0 - (_animationController.value - i / 3).abs())
                          .clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.only(right: i < 2 ? 6.0 : 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Drawer _buildEndDrawer(BuildContext context) {
    final routeNames = RouteDataProvider.getAllRouteNames();

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: routeNames.map((routeInfo) {
                return CustomBlueButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.go(RouteDataProvider.getFullPath(routeInfo) ?? '/');
                  },
                  text: routeInfo,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isUser = message['role'] == 'user';

        return Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color:
                    isUser ? const Color(0xFFDFEAFF) : const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(
                message['content']!,
                style: TextStyle(
                  color: isUser ? const Color(0xFF1777E9) : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter message',
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}
