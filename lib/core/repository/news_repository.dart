import 'package:world_cue/core/network/api_endpoints.dart';
import 'package:world_cue/core/network/dio_client.dart';
import 'package:world_cue/core/network/exception.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class NewsRepository {
  final DioClient _dioClient = DioClient();

  /// Fetch Top Headlines with Pagination
  Future<({List<NewsModel> news, bool hasMore, int totalPages})> getNews({
    String? query,
    String? category,
    String lang = "en",
    int max = 20,
    int page = 1,
    DateTime? from,
    DateTime? to,
    List<String>? nullableFields,
  }) async {
    try {
      final queryParams = {
        if (query != null && query.isNotEmpty) "q": query,
        "lang": lang,
        "max": max.toString(),
        "page": page.toString(),
        "category": category,
        "pageSize": max.toString(),
        if (from != null) "from": from.toUtc().toIso8601String(),
        if (to != null) "to": to.toUtc().toIso8601String(),
        if (nullableFields != null && nullableFields.isNotEmpty)
          "nullable": nullableFields.join(","),
      };

      final response = await _dioClient.getRequest(
        endPoint: ApiEndpoints.getNews,
        queryParameters: queryParams,
      );

      final data = response.data;

      if (data == null || data['articles'] == null) {
        throw Exception("Invalid response from server");
      }

      final List<dynamic> articles = data['articles'];
      final List<NewsModel> newsList =
      articles.map((e) => NewsModel.fromJson(e)).toList();

      final pagination = data['pagination'] ?? {};
      final bool hasMore = (pagination['hasNextPage'] ?? false) as bool;
      final int totalPages = (pagination['totalPages'] ?? 1) as int;

      return (news: newsList, hasMore: hasMore, totalPages: totalPages);
    } on BaseApiException catch (e) {
      throw Exception("API Error: ${e.errorMessage}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

}
