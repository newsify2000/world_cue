import 'dart:async';
import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/network/gemini_service.dart';
import 'package:world_cue/repositories/news_repository.dart';

class NewsSearchController extends GetxController {
  /// --------------------------
  /// Dependencies
  /// --------------------------
  final NewsRepository _newsRepo = NewsRepository();
  final NewsSummarizerService _summarizer = NewsSummarizerService();

  /// --------------------------
  /// Reactive State
  /// --------------------------
  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool isSearching = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxString currentQuery = ''.obs;

  /// debounce timer for user typing
  Timer? _debounce;

  /// initial loading state flag
  bool get isInitialLoading => isLoading.value && newsList.isEmpty;

  /// --------------------------
  /// Search Handling
  /// --------------------------
  void onSearchChanged(String value) {
    _debounce?.cancel();

    final query = value.trim();

    /// empty input = reset
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    /// wait before firing API call
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (query.length >= 3) {
        searchNews(page: 1, query: query);
      } else {
        clearSearch();
      }
    });
  }

  /// main fetch logic
  Future<void> searchNews({required int page, required String query}) async {
    /// avoid duplicate calls
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSearching.value = true;
      currentQuery.value = query;

      /// call repo
      final result = await _newsRepo.searchNews(query: query, page: page);

      /// page 1 = fresh list
      if (page == 1) {
        newsList.assignAll(result.news);
      } else {
        /// avoid duplicate news items
        final newItems = result.news.where(
              (n) => !newsList.any((existing) => existing.link == n.link),
        );
        newsList.addAll(newItems);
      }

      /// update flags
      hasMore.value = result.hasMore;
      currentPage.value = page;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// --------------------------
  /// Pagination
  /// --------------------------
  Future<void> loadMore() async {
    /// stop if already loading or done
    if (isLoading.value || !hasMore.value || currentQuery.value.isEmpty) return;

    final nextPage = currentPage.value + 1;
    await searchNews(page: nextPage, query: currentQuery.value.trim());
  }

  /// --------------------------
  /// Utility Functions
  /// --------------------------
  void clearSearch() {
    isSearching.value = false;
    currentQuery.value = '';
    hasMore.value = true;
    currentPage.value = 1;
    newsList.clear();
  }

  Future<String> summarizeNews(NewsModel news) async {
    /// summarizer call (AI summary)
    return await _summarizer.getNewsShortSummary(
      sourceLink: news.sourceLink,
      newsText: news.description,
      title: news.title,
    );
  }


  /// --------------------------
  /// Cleanup
  /// --------------------------
  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
