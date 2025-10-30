import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/network/gemini_service.dart';
import 'package:world_cue/repositories/news_repository.dart';

class HomeController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    fetchNews(page: currentPage.value);
  }

  /// Fetch headlines with pagination
  Future<void> fetchNews({int page = 1, String? category}) async {
    if (isLoading.value || (!hasMore.value && page != 1)) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final topic = category ?? currentCategory.value;

      final result = await _newsRepo.getTopHeadlines(topic: topic, page: page);

      if (page == 1) {
        newsList.assignAll(result.news);
      } else {
        newsList.addAll(result.news);
      }

      currentCategory.value = topic;
      currentPage.value = page;
      hasMore.value = result.hasMore;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

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

  /// Refresh headlines (reset pagination)
  Future<void> refreshNews() async {
    hasMore.value = true;
    await fetchNews(page: 1, category: currentCategory.value);
  }

  /// Reset search and go back to headlines
  void clearSearch() {
    isSearching.value = false;
    currentQuery.value = '';
    hasMore.value = true;
    currentPage.value = 1;
    fetchNews(page: 1, category: currentCategory.value);
  }

  /// search with categories
  void updateCategory(String category) {
    if (currentCategory.value != category) {
      currentCategory.value = category;
      currentPage.value = 1;
      hasMore.value = true;
      fetchNews(page: 1, category: category);
    }
  }

  Future<String> summarizeNews(NewsModel news) async {
    return await _summarizer.getNewsSummary(
      newsText: news.description,
      title: news.title,
    );
  }
}
