import 'package:feature_navigator/component/custom_button.dart';
import 'package:feature_navigator/model/gpt_model.dart';
import 'package:feature_navigator/model/utils.dart';
import 'package:feature_navigator/provider/gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../feature_router.dart';
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

  int _currentPage = 0;
  final int _buttonsPerPage = 5;

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
      _addMessage(
          'assistant', '안녕하세요! 저는 원하는 기능들을 찾아주는 도우미에요. 궁금한 기능이 있으시면 물어봐주세요.');
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
        .matchedLocation
        .toString();

    _addMessage('user', message);
    _controller.clear();
    _setTyping(true);
    await Future.delayed(const Duration(seconds: 1));

    final routeInfoProvider = RouteInfoProvider(routes: allRoutes);

    switch (message) {
      case '너는 무엇을 할 수 있어?':
        _addMessage('assistant',
            '저는 사용자의 질문을 듣고 그에 맞는 화면으로 이동을 도와드리고 있어요. 또한, 화면에 대해 모르는 부분도 알려드리고 있습니다.');
        break;
      case '화면 목록을 보여줘':
        _setChattingState(ChattingState.showRoutes);
        break;
      case '이전 화면에 대해서 설명해줘':
        final routeDescription = routeInfoProvider.getRoutesInfo().firstWhere(
              (route) => route['path'] == currentRoute,
              orElse: () => {'description': '화면 설명을 찾을 수 없습니다.'},
            )['description'];
        _addMessage('assistant', '현재 화면은 $routeDescription');
        break;
      case '최근에 검색한 화면을 보여줘':
        _addMessage('assistant', '다음은 최근에 검색한 화면들이에요. 다시 이동하고 싶은 화면이 있나요?');
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
    if (message != '화면 목록을 보여줘') {
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

  List<Widget> _buildActionButtons(RouteInfoProvider routeInfoProvider) {
    final initialButtonContents = [
      '너는 무엇을 할 수 있어?',
      '화면 목록을 보여줘',
      '이전 화면에 대해서 설명해줘',
      '최근에 검색한 화면을 보여줘'
    ];

    switch (_chatPageState) {
      case ChattingState.initial:
        return [
          CustomBlueButton(
            onPressed: () {
              _addMessage('user', '시작');
              _setChattingState(ChattingState.listView);
            },
            text: "시작",
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
      case ChattingState.showRoutes:
        // 전체 Route 정보 리스트
        final routeInfos = routeInfoProvider.getRoutesInfo();

        // 현재 페이지에 해당하는 Route 정보만 가져오기
        final startIndex = _currentPage * _buttonsPerPage;
        final endIndex = (_currentPage + 1) * _buttonsPerPage;
        final currentRoutes = routeInfos.sublist(
          startIndex,
          endIndex > routeInfos.length ? routeInfos.length : endIndex,
        );

        // 현재 페이지의 버튼들 생성
        final buttons = currentRoutes.map((routeInfo) {
          return CustomBlueButton(
            onPressed: () {
              context.go(routeInfo['path']!);
            },
            text: routeInfo['name']!,
          );
        }).toList();

        // 페이지 네비게이션 버튼 추가
        if (_currentPage > 0) {
          buttons.add(
            CustomBlueButton(
              onPressed: () {
                setState(() {
                  _currentPage--;
                });
              },
              text: "이전 페이지",
            ),
          );
        }
        if (endIndex < routeInfos.length) {
          buttons.add(
            CustomBlueButton(
              onPressed: () {
                setState(() {
                  _currentPage++;
                });
              },
              text: "다음 페이지",
            ),
          );
        }

        // 처음으로 돌아가기 버튼 추가
        buttons.add(
          CustomBlueButton(
            onPressed: () {
              _setChattingState(ChattingState.listView);
              _currentPage = 0; // 페이지를 초기화
            },
            text: "처음으로 돌아가기",
          ),
        );

        return buttons;
      case ChattingState.detailView:
        return [
          CustomBlueButton(
            onPressed: () {
              _setChattingState(ChattingState.listView);
            },
            text: "처음으로 돌아가기",
          ),
        ];
      default:
        return [];
    }
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
            child: _buildMessageList(),
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
                hintText: '메시지 입력',
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }
}
