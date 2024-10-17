import 'package:feature_navigator/view/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model/gpt_model.dart';

List<FeatureRoute> _allRoutes = [];
get allRoutes => _allRoutes;

class FeatureRoute extends GoRoute {
  final String description;
  final bool includeChat;

  FeatureRoute({
    required this.description,
    required super.path,
    required Widget Function(BuildContext, GoRouterState) builder,
    this.includeChat = true,
    super.name,
    super.pageBuilder,
    super.redirect,
    super.routes = const <RouteBase>[],
  }) : super(
          builder: (context, state) {
            final child = builder(context, state);
            final settings = FeatureSettings();

            if (includeChat && settings.aiApiKey != null) {
              return Stack(
                children: [
                  child,
                  Positioned(
                    right: 24.0,
                    bottom: 40.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatPage()),
                        );
                      },
                      child: const Icon(Icons.chat),
                    ),
                  ),
                ],
              );
            }
            return child;
          },
        ) {
    _allRoutes.add(this);
  }
}
