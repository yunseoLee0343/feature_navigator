import 'dart:convert';

import 'package:feature_navigator/feature_router.dart';
import 'package:feature_navigator/model/gpt_model.dart';
import 'package:feature_navigator/provider/feature_router_provider.dart';
import 'package:http/http.dart' as http;

class GPTService {
  final String apiKey;
  final GPTModel gptModel;

  GPTService(this.apiKey, this.gptModel);

  Future<String> sendMessage(String message) async {
    final routeInfoProvider = RouteInfoProvider(routes: allRoutes);
    final systemMessage =
        "You are a navigator that provides directions to the user. Please guide the user to the router that has the desired feature. [Router List] ${routeInfoProvider.getRoutesInfo()}. Please respond in the following format: [Response Format]: 찾으시는 기능이 [Page Name] 맞으신가요?";
    // print(systemMessage);
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': gptModel.modelName,
        'messages': [
          {
            'role': 'system',
            'content': systemMessage,
          },
          {'role': 'user', 'content': message},
        ],
      }),
    );

    // print('Status code: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to communicate with GPT');
    }
  }
}
