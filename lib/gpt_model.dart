// lib/gpt_model.dart

enum GPTModel {
  gpt4oNEW('gpt-4o-2024-08-06'),
  gpt4o('gpt-4o'),
  gpt4oMini('gpt-4o-mini');

  final String modelName;

  const GPTModel(this.modelName);
}

class FeatureSettings {
  static final FeatureSettings _instance = FeatureSettings._internal();

  bool useAI = false;
  String? aiApiKey;
  GPTModel? gptModel;

  factory FeatureSettings() {
    return _instance;
  }

  FeatureSettings._internal();

  void configure({
    required bool useAI,
    String? aiApiKey,
    GPTModel? gptModel,
  }) {
    this.useAI = useAI;
    this.aiApiKey = aiApiKey;
    this.gptModel = gptModel;
  }
}
