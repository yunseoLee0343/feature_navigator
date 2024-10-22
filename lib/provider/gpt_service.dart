import 'dart:convert';

import 'package:feature_navigator/model/gpt_model.dart';
import 'package:feature_navigator/provider/feature_router_provider.dart';
import 'package:http/http.dart' as http;

class GPTService {
  final String apiKey;
  final GPTModel gptModel;

  GPTService(this.apiKey, this.gptModel);

  Future<Map<String, dynamic>> sendMessage(String message) async {
    String systemMessage = """
You are a helpful navigation assistant for a mobile app. Based on the user's input and the available screens, suggest the most appropriate screen. If the user's request doesn't match any available screen, provide a friendly message explaining that you couldn't find a matching screen, possible reasons why, and ask the user if they could rephrase or provide more details.

Available screens: ${RouteDataProvider.getAllRouteNames()}

Please respond in the following JSON format:

{
  "found": true/false,
  "route_name": "name of the route (if found, else empty string)",
  "message": "your message to the user"
}

If a screen is found:
- Set "found" to true.
- Provide the "route_name".
- Include a message like "I found the [route_name] screen for you."

If no matching screen is found:
- Set "found" to false.
- Set "route_name" to an empty string.
- Include a message that explains you couldn't find a matching screen, possible reasons, and politely ask the user to rephrase or provide more details. For example, "I'm sorry, I couldn't find a screen matching your request. Could you please rephrase or provide more details?"

Make sure your response is in valid JSON format without any additional text.
""";

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
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final content = data['choices'][0]['message']['content'].trim();

      try {
        // Parse the GPT response as JSON
        final result = jsonDecode(content) as Map<String, dynamic>;
        return result;
      } catch (e) {
        throw Exception('Invalid JSON response from GPT: $e');
      }
    } else {
      throw Exception('Failed to communicate with GPT');
    }
  }
}
