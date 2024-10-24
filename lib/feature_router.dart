import 'package:feature_navigator/provider/feature_router_provider.dart';
import 'package:feature_navigator/view/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model/gpt_model.dart';

List<FeatureRoute> _allRoutes = [];
get allRoutes => _allRoutes;

class FeatureRoute extends GoRoute {
  final String description;
  final bool includeChat;
  final Map<String, dynamic> parameters;
  final Map<String, Map<String, dynamic>> extras;

  FeatureRoute({
    required this.description,
    this.parameters = const {},
    required super.path,
    required Widget Function(BuildContext, GoRouterState) builder,
    required super.name,
    this.includeChat = true,
    super.pageBuilder,
    super.redirect,
    super.routes = const <RouteBase>[],
    this.extras = const {},
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
    // Add this route to the global list of all routes
    _allRoutes.add(this);
  }
}

class FeatureRouter {
  final GoRouter _router;

  FeatureRouter({
    required GoRouter goRouter,
    required String apiKey,
    GPTModel? gptModel,
  }) : _router = goRouter {
    FeatureSettings().configure(
      aiApiKey: apiKey,
      gptModel: gptModel,
    );

    RouteDataProvider.initializeRoutes(_router.configuration.routes);
  }

  GoRouter get router => _router;
}
