import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:world_cue/core/utils/constants.dart';

class GeminiService {
  final String _apikey = NetworkConstants.geminiKey;
  final String geminiModel = SharedPrefConstants.geminiModel;

  Future<Map<String, dynamic>> getTrendingTopics({int limit = 10}) async {
    final String prompt =
        '''
Please identify and list **$limit current trending global news topics** and **$limit current trending India news topics** based on the latest headlines and public interest worldwide. 
Each item must be an object containing two keys:
1.  **"topic"**: A concise phrase (2–5 words) representing a distinct event, issue, or figure currently making headlines.
2.  **"category"**: A single, relevant, lowercase word (e.g., "politics", "environment", "technology", "sports") describing the topic's general area.

Avoid repetition, vague terms, or generic words — focus on *specific trending subjects*.

Return the result strictly in this JSON format:
{
  "global": [
    {"topic": "Topic 1", "category": "category1"}, 
    {"topic": "Topic 2", "category": "category2"},
    ..., 
    {"topic": "Topic $limit", "category": "category$limit"}
  ],
  "india": [
    {"topic": "Topic 1", "category": "category1"}, 
    {"topic": "Topic 2", "category": "category2"},
    ..., 
    {"topic": "Topic $limit", "category": "category$limit"}
  ]
}

***IMPORTANT ERROR HANDLING RULE***: 
If you cannot determine trending topics due to missing or invalid data, you MUST return only the exact string: [ERROR_INVALID_CONTENT].
Do not include any other text.

---
Query Context:
Fetch trending topics that are globally and nationally relevant at this moment.
Ensure all topics are real, time-sensitive, and reflect current events or discussions.
---
''';
    // ... rest of the method remains the same ...

    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/$geminiModel:generateContent?key=$_apikey",
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

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        log("Error: ${response.statusCode}");
        log("Response body: ${response.body}");
        throw Exception(
          "Failed to fetch trending topics (HTTP ${response.statusCode})",
        );
      }

      final data = jsonDecode(response.body);
      final answer = data['candidates']?[0]?['content']?['parts']?[0]?['text']
          ?.trim();

      if (answer == null ||
          answer.isEmpty ||
          answer == "[ERROR_INVALID_CONTENT]") {
        throw Exception("[ERROR_INVALID_CONTENT]");
      }

      // Gemini may return JSON as code block → clean that up
      final cleaned = answer
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      final Map<String, dynamic> parsed = jsonDecode(cleaned);

      // Validate structure
      if (!parsed.containsKey('global') || !parsed.containsKey('india')) {
        throw Exception("Invalid structure from Gemini");
      }

      // Cache result

      return parsed;
    } catch (e, st) {
      log("Error fetching trending topics: $e");
      log(st.toString());

      rethrow;
    }
  }
}
