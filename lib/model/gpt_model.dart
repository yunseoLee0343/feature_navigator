// lib/gpt_model.dart

enum GPTModel {
  gpt4o('gpt-4o'),
  gpt4oMini('gpt-4o-mini');

  final String modelName;

  const GPTModel(this.modelName);
}

class FeatureSettings {
  static final FeatureSettings _instance = FeatureSettings._internal();

  String? aiApiKey;
  GPTModel? gptModel = GPTModel.gpt4oMini;

  factory FeatureSettings() {
    return _instance;
  }

  FeatureSettings._internal();

  void configure({
    String? aiApiKey,
    GPTModel? gptModel,
  }) {
    this.aiApiKey = aiApiKey;
    this.gptModel = gptModel;
  }
}
