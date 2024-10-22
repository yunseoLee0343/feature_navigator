// lib/provider/search_history_service.dart

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _searchHistoryKey = 'search_history';

  /// Saves a search message and its corresponding path to SharedPreferences.
  ///
  /// The [message] is used as the key, and the [path] is the value.
  static Future<void> saveSearch(String message, String path) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve existing search history as a JSON string
    final String? searchHistoryJson = prefs.getString(_searchHistoryKey);
    Map<String, String> searchHistory = {};

    if (searchHistoryJson != null) {
      // Decode the JSON string to a Map
      try {
        final decoded = json.decode(searchHistoryJson);
        // Ensure that the decoded JSON is a Map<String, dynamic>
        if (decoded is Map<String, dynamic>) {
          // Convert Map<String, dynamic> to Map<String, String>
          searchHistory =
              decoded.map((key, value) => MapEntry(key, value.toString()));
        }
      } catch (e) {
        // If decoding fails, initialize an empty map
        searchHistory = {};
      }
    }

    // Add the new search entry
    searchHistory[message] = path;

    // Encode the updated map back to JSON
    final String updatedSearchHistoryJson = json.encode(searchHistory);

    // Save the updated JSON string to SharedPreferences
    await prefs.setString(_searchHistoryKey, updatedSearchHistoryJson);
  }
}
