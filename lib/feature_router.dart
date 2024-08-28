import 'package:go_router/go_router.dart';

import 'feature_route.dart';
import 'model/gpt_model.dart';

class FeatureRouter {
  final GoRouter _router;

  FeatureRouter({
    required bool useAI,
    String? aiApiKey,
    GPTModel? gptModel,
    required List<FeatureRoute> routes,
  }) : _router = GoRouter(
          routes: routes,
        ) {
    FeatureSettings().configure(
      useAI: useAI,
      aiApiKey: aiApiKey,
      gptModel: gptModel,
    );
  }

  GoRouter get router => _router;
}
