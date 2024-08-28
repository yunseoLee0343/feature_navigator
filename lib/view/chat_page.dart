import 'package:feature_navigator/component/custom_button.dart';
import 'package:feature_navigator/model/gpt_model.dart';
import 'package:feature_navigator/model/utils.dart';
import 'package:feature_navigator/provider/gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../feature_route.dart';
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

  final List<Map<String, String>> _messages = [
    {
      'role': 'assistant',
      'content':
          '안녕하세요. Feature Navigator 도우미입니다 😀 \n\n도움을 원하시는 경우, 아래 시작 버튼을 누르거나 채팅을 입력해주세요. \n\nAI가 제공하는 정보는 실제와 다를 수 있으니 참고용으로만 사용해주시기 바랍니다.'
    }
  ];
  late GPTService _gptService;
  late AnimationController _animationController;
  ChattingState _chatPageState = ChattingState.initial;
  bool _isUserDeterminedPath = false;
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
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _setTyping(bool typing) {
    setState(() {
      _isTyping = typing;
    });
  }

  Future<void> _addDelayedMessage(String role, String content) async {
    _setTyping(true);

    await Future.delayed(const Duration(seconds: 1));
    _addMessage(role, content);

    _setTyping(false);
  }

  void _setChattingState(ChattingState state) {
    setState(() {
      _chatPageState = state;
    });
  }

  void _sendMessage() async {
    final message = _controller.text;

    if (message.isEmpty) return;

    _addMessage('user', message);
    _controller.clear();

    _setTyping(true);
    await Future.delayed(const Duration(seconds: 1));

    if (message == '시작') {
      _addMessage(
          'assistant', '문의 내용을 선택해 주세요. \n\n처음으로 돌아오려면 ' '시작' '을 입력해주세요.');
      _setChattingState(ChattingState.listView);

      _controller.clear();
      _setTyping(false);
      return;
    }

    try {
      final response = await _gptService.sendMessage(message);
      _setTyping(false);
      _addMessage('assistant', response);
    } catch (e) {
      _setTyping(false);
      _addMessage('assistant', 'Error: Could not fetch response from GPT. $e');
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

  List<Widget> _buildActionButtons(RouteInfoProvider routeInfoProvider) {
    final List<String> buttonContents = routeInfoProvider
        .getRoutesInfo()
        .map((routeInfo) => routeInfo['name']!)
        .toList();

    switch (_chatPageState) {
      case ChattingState.initial:
        return [
          CustomBlueButton(
            onPressed: () {
              _addMessage('user', '시작');
              _addDelayedMessage('assistant',
                  '문의 내용을 선택해 주세요. \n처음으로 돌아오려면 ' '시작' '을 입력해주세요.');
              _setChattingState(ChattingState.listView);
            },
            text: "시작",
          ),
        ];
      case ChattingState.listView:
        return buttonContents.map((content) {
          return CustomBlueButton(
            onPressed: () {
              _controller.text = '$content에 대해서 알고 싶어요.';
              _sendMessage();
              _addDelayedMessage('assistant',
                  '해당 화면은 \n${routeInfoProvider.getRouteDescription(content)}');
              _setUserDeterminedPath();
              _setChattingState(ChattingState.detailView);
            },
            text: '$content에 대해서 알고 싶어요.',
          );
        }).toList();
      case ChattingState.detailView:
        return [
          CustomBlueButton(
            onPressed: () {
              _addMessage('user', '아니요. 도움이 필요합니다');
              _addDelayedMessage(
                  'assistant',
                  '추가적인 문의 사항은 메시지를 입력해서 요청해주세요. \n처음으로 돌아오려면 '
                      '시작'
                      '을 입력해주세요.');
              _setChattingState(ChattingState.reponsed);
            },
            text: "아니요. 도움이 필요합니다",
          ),
        ];
      case ChattingState.reponsed:
        return [];
      default:
        return [];
    }
  }

  void _setUserDeterminedPath() {
    setState(() {
      _isUserDeterminedPath = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeInfoProvider = RouteInfoProvider(routes: allRoutes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT Chat'),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.white,
      endDrawer: _buildEndDrawer(context, routeInfoProvider),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildMessageList(routeInfoProvider),
          ),
          if (_isTyping) _buildTypingIndicator(),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _buildActionButtons(routeInfoProvider),
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
        children: [
          for (int i = 0; i < 3; i++)
            AnimatedBuilder(
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
            ),
        ],
      ),
    );
  }

  Drawer _buildEndDrawer(
      BuildContext context, RouteInfoProvider routeInfoProvider) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: routeInfoProvider.getRoutesInfo().map((routeInfo) {
              return SizedBox(
                width: 100,
                child: CustomBlueButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go(routeInfo['path']!);
                  },
                  text: routeInfo['name']!,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(RouteInfoProvider routeInfoProvider) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final path = _extractPath(message, routeInfoProvider);
        final match = _extractMatch(message, routeInfoProvider);
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
            if (path.isNotEmpty && !isUser)
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: CustomBlueButton(
                  isOutlined: false,
                  onPressed: () {
                    context.go(path);
                  },
                  text: "$match로 이동하기",
                ),
              ),
          ],
        );
      },
    );
  }

  String _extractPath(
      Map<String, String> message, RouteInfoProvider routeInfoProvider) {
    if (message['role'] == 'assistant') {
      final regExp = RegExp(r'찾으시는 기능이 (.*?) 맞으신가요\?');

      final match = regExp.firstMatch(message['content']!);

      if (match != null) {
        final extracted = match.group(1)?.trim() ?? '';
        return routeInfoProvider.getRoutePath(extracted);
      }
    } else if (_isUserDeterminedPath) {
      _isUserDeterminedPath = false;
      return message['content']!;
    }
    return '';
  }

  String _extractMatch(
      Map<String, String> message, RouteInfoProvider routeInfoProvider) {
    if (message['role'] == 'assistant') {
      final regExp = RegExp(r'찾으시는 기능이 (.*?) 맞으신가요\?');

      final match = regExp.firstMatch(message['content']!);

      if (match != null) {
        final extracted = match.group(1)?.trim() ?? '';
        return extracted;
      }
    } else if (_isUserDeterminedPath) {
      _isUserDeterminedPath = false;
      return message['content']!;
    }
    return '';
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
                hintText: '메시지 입력',
              ),
              onSubmitted: (value) {
                _sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
