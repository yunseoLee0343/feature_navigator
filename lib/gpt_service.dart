import 'dart:convert';

import 'package:feature_navigator/gpt_model.dart';
import 'package:http/http.dart' as http;

class GPTService {
  final String apiKey;
  final GPTModel gptModel;

  GPTService(this.apiKey, this.gptModel);

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': gptModel.modelName,
        'messages': [
          {'role': 'system', 'content': 'You are a helpful assistant.'},
          {'role': 'user', 'content': message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to communicate with GPT');
    }
  }
}
