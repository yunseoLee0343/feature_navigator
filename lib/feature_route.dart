import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model/gpt_model.dart';
import 'view/chat_page.dart';

List<FeatureRoute> _allRoutes = [];
get allRoutes => _allRoutes;

class FeatureRoute extends GoRoute {
  final String description;
  final bool includeChat;

  FeatureRoute({
    required this.description,
    required super.path,
    required Widget Function(BuildContext, GoRouterState) builder,
    this.includeChat = false,
    super.name,
    super.pageBuilder,
    super.redirect,
    super.routes = const <RouteBase>[],
  }) : super(
          builder: (context, state) {
            final child = builder(context, state);
            final settings = FeatureSettings();

            if (includeChat && settings.useAI) {
              return Scaffold(
                body: child,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.chat),
                ),
              );
            }
            return child;
          },
        ) {
    _allRoutes.add(this);
  }
}
