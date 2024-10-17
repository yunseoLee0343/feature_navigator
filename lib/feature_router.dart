import 'package:go_router/go_router.dart';

import 'feature_route.dart';
import 'model/gpt_model.dart';

class FeatureRouter {
  final GoRouter _router;

  FeatureRouter({
    GPTModel? gptModel,
    String? apiKey,
    required List<FeatureRoute> routes,
  }) : _router = GoRouter(routes: routes) {
    FeatureSettings().configure(
      aiApiKey: apiKey,
      gptModel: gptModel,
    );
  }

  GoRouter get router => _router;
}
