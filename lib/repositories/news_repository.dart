import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/network/api_endpoints.dart';
import 'package:world_cue/network/dio_client.dart';
import 'package:world_cue/network/exception.dart';

class NewsRepository {
  static const String apiKey = "1b98285e5ac5e8316450d752c897591e";
  final DioClient _dioClient = DioClient();

  /// Fetch Top Headlines with Pagination
  Future<({List<NewsModel> news, bool hasMore})> getTopHeadlines({
    String? topic,
    String lang = "en",
    String country = "in",
    int max = 10,
    int page = 1,
  }) async {
    try {
      final queryParams = {
        "country": country,
        "lang": lang,
        "max": max.toString(),
        "page": page.toString(),
        "apikey": apiKey,
        if (topic != null && topic.isNotEmpty) "topic": topic,
      };

      final response = await _dioClient.getRequest(
        endPoint: ApiEndpoints.topHeadlines,
        queryParameters: queryParams,
      );

      final List<dynamic> articles = response.data['articles'] ?? [];

      final newsList = articles.map((article) {
        final source = article['source'] ?? {};
        return NewsModel(
          title: article['title'] ?? '',
          link: article['url'] ?? '',
          imageLink: article['image'] ?? '',
          description: article['content'] ?? '',
          publishedAt: article['publishedAt'] ?? '',
          sourceName: source['name'] ?? '',
          sourceLink: source['url'] ?? '',
        );
      }).toList();

      // Pagination stop condition:
      final hasMore = newsList.length >= max;

      return (news: newsList, hasMore: hasMore);
    } on BaseApiException catch (e) {
      throw Exception("API Error: ${e.errorMessage}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  /// Search News with Pagination
  Future<({List<NewsModel> news, bool hasMore})> searchNews({
    required String query,
    String lang = "en",
    String country = "in",
    int max = 10,
    int page = 1,
  }) async {
    try {
      final queryParams = {
        "q": query,
        "lang": lang,
        "country": country,
        "max": max.toString(),
        "page": page.toString(),
        "apikey": apiKey,
      };

      final response = await _dioClient.getRequest(
        endPoint: ApiEndpoints.search,
        queryParameters: queryParams,
      );

      final List<dynamic> articles = response.data['articles'] ?? [];

      final newsList = articles.map((article) {
        final source = article['source'] ?? {};
        return NewsModel(
          title: article['title'] ?? '',
          link: article['url'] ?? '',
          imageLink: article['image'] ?? '',
          description: article['content'] ?? '',
          publishedAt: article['publishedAt'] ?? '',
          sourceName: source['name'] ?? '',
          sourceLink: source['url'] ?? '',
        );
      }).toList();

      // Pagination stop condition:
      final hasMore = newsList.length >= max;

      return (news: newsList, hasMore: hasMore);
    } on BaseApiException catch (e) {
      throw Exception("API Error: ${e.errorMessage}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
