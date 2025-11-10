import 'package:get/get.dart';
import 'package:world_cue/core/network/api_endpoints.dart';
import 'package:world_cue/core/network/dio_client.dart';
import 'package:world_cue/core/network/exception.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class NewsRepository {
  final DioClient _dioClient = DioClient();

  /// Fetch Top Headlines with Pagination
  Future<({List<NewsModel> news, int totalPages})> getNewsByCategory({
    String? category,
    int pageSize = 10,
    int page = 1,
  }) async
  {
    String currentLang = Get.locale?.languageCode ?? 'en';
    try {
      final queryParams = {
        "lang": currentLang,
        "pageSize": pageSize.toString(),
        "page": page.toString(),
        "category": category,
      };

      final response = await _dioClient.getRequest(
        endPoint: ApiEndpoints.getNewsByCategory,
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
      final int totalPages = (pagination['totalPages'] ?? 1) as int;

      return (news: newsList, totalPages: totalPages);
    } on BaseApiException catch (e) {
      throw Exception("API Error: ${e.errorMessage}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<({List<NewsModel> news, bool hasMore, int totalPages})> searchNews({
    String? query,
    String? category,
    int max = 10,
    int page = 1,
    DateTime? from,
    DateTime? to,
    List<String>? nullableFields,
  }) async
  {
    String currentLang = Get.locale?.languageCode ?? 'en';
    try {
      final queryParams = {
        if (query != null && query.isNotEmpty) "q": query,
        "lang": currentLang,
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
        endPoint: ApiEndpoints.searchNews,
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
