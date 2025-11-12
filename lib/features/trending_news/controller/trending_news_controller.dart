import 'dart:async';

import 'package:get/get.dart';
import 'package:world_cue/core/repository/news_repository.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class TrendingNewsController extends GetxController {
  final String topic;
  TrendingNewsController({required this.topic});

  /// --------------------------
  /// Dependencies
  /// --------------------------
  final NewsRepository _newsRepo = NewsRepository();

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

  @override
  void onInit() {
    super.onInit();
    searchNews(page: 1, query: topic);
  }

  /// initial loading state flag
  bool get isInitialLoading => isLoading.value && newsList.isEmpty;

  /// --------------------------
  /// Search Handling
  /// --------------------------


  /// main fetch logic
  Future<void> searchNews({required int page, required String query}) async {
    if (isLoading.value) return; // avoid duplicate calls

    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSearching.value = true;
      currentQuery.value = query;

      /// call new repo method
      final result = await _newsRepo.searchNews(
        query: query,
        page: page,
        max: 10,
      );

      /// page 1 = fresh list
      if (page == 1) {
        newsList.assignAll(result.news);
      } else {
        /// avoid duplicate news items
        final newItems = result.news.where(
          (n) => !newsList.any((existing) => existing.id == n.id),
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
    if (isLoading.value || currentQuery.value.isEmpty) return;

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

  /// --------------------------
  /// Cleanup
  /// --------------------------
  @override
  void onClose() {
    super.onClose();
  }
}
