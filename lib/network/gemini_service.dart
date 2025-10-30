import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_cue/utils/constants.dart';

// NOTE: In a production app, the API key should be stored securely (e.g., environment variables),
// not hardcoded directly in the source file.
class NewsSummarizerService {
  // Using the same API Key and model structure as your original class
  final String _apikey = NetworkConstants.geminiKey;
  final String model = "gemini-2.5-flash";

  // A helper method to create a unique key for caching this news summary.
  String _getCacheKey(String title) => 'summary_$title';

  /// Generates a 60-word summary of a news article using the Gemini API.
  Future<String> getNewsSummary({
    required String newsText,
    required String title,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final cacheKey = _getCacheKey(title);

    String? isPresent = await checkAvailableInfo(
      cacheKey: cacheKey,
      sharedPreferences: sharedPreferences,
    );

    if (isPresent == null) {
      log("In getNewsSummary: Generating new summary for '$title'");

      // The refined prompt instructing the model to summarize the article
      // AND handle unsummarizable content with a specific error code.
      final String prompt =
          '''
Summarize the following news article in about 60 words. Focus on the main topic, key events, and the most important outcome. Do not exceed 80 words.
It is for my application, so the paragraph should look like an app is returning a result. Do not include any introductory phrases like 'The article summarizes...' or questions.

***IMPORTANT ERROR HANDLING RULE***: 
If the provided 'Article Content' is empty, non-textual, or nonsensical and you cannot extract a summary, you MUST return only the exact string: [ERROR_INVALID_CONTENT]. 
Do not add any other text if you return this error code.

---
Title : $title
Article Content:
$newsText
---
''';

      final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$_apikey",
      );

      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
      });

      http.Response response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final answer =
            data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        String info =
            answer ?? "Cannot summarize this article (API structure error).";

        // Save the generated info (even the error code) to cache
        bool saved = await sharedPreferences.setString(cacheKey, info);
        log("Info Saved in cache with key '$cacheKey': $saved");

        return info;
      } else {
        log("Error: ${response.statusCode}");
        log("Response body: ${response.body}");
        return "ERROR_FAILED_TO_GET_SUMMARY (STATUS_CODE:${response.statusCode})";
      }
    } else {
      log("Info Loaded from cache for '$title'");
      return isPresent;
    }
  }

  /// Checks if a summary for the given key is available in SharedPreferences.
  Future<String?> checkAvailableInfo({
    required String cacheKey,
    required SharedPreferences sharedPreferences,
  }) async {
    return sharedPreferences.getString(cacheKey);
  }
}
