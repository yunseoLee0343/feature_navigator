// lib/provider/chat_history_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryService {
  static const String _chatMessagesKey = 'chat_messages';
  static const int _maxMessages = 5;

  /// Saves a single chat message to SharedPreferences.
  ///
  /// - If the message already exists, it removes the old instance.
  /// - If there are already five messages, it removes the oldest one.
  /// - The new message is added to the beginning of the list.
  static Future<void> saveMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing messages
    List<String> messages = prefs.getStringList(_chatMessagesKey) ?? [];

    // Remove the message if it already exists to prevent duplicates
    messages.remove(message);

    // Add the new message to the beginning
    messages.insert(0, message);

    // Ensure only the latest five messages are kept
    if (messages.length > _maxMessages) {
      messages = messages.sublist(0, _maxMessages);
    }

    // Save the updated list back to SharedPreferences
    await prefs.setStringList(_chatMessagesKey, messages);
  }

  /// Loads the list of saved chat messages from SharedPreferences.
  ///
  /// Returns a list of messages, ordered from newest to oldest.
  static Future<List<String>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing messages
    List<String> messages = prefs.getStringList(_chatMessagesKey) ?? [];

    return messages;
  }

  /// Clears all saved chat messages from SharedPreferences.
  static Future<void> clearChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chatMessagesKey);
  }
}
