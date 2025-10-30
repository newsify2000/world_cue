import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/network/gemini_service.dart';
import 'package:world_cue/repositories/news_repository.dart';

class NewsSearchController extends GetxController {
  final NewsRepository _newsRepo = NewsRepository();
  final NewsSummarizerService _summarizer = NewsSummarizerService();

  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxString currentCategory = 'general'.obs;

  final RxBool isSearching = false.obs;
  final RxString currentQuery = ''.obs;

  /// Search news with pagination
  Future<void> searchNews({required int page, required String query}) async {
    if (isLoading.value || (!hasMore.value && page != 1)) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSearching.value = true;
      currentQuery.value = query;

      final result = await _newsRepo.searchNews(query: query, page: page);

      if (page == 1) {
        newsList.assignAll(result.news);
      } else {
        newsList.addAll(result.news);
      }

      hasMore.value = result.hasMore;
      currentPage.value = page;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset search and go back to headlines
  void clearSearch() {
    isSearching.value = false;
    currentQuery.value = '';
    hasMore.value = true;
    currentPage.value = 1;
  }

  Future<String> summarizeNews(NewsModel news) async {
    return await _summarizer.getNewsSummary(
      newsText: news.description,
      title: news.title,
    );
  }
}
