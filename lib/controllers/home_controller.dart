import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/network/gemini_service.dart';
import 'package:world_cue/repositories/news_repository.dart';
import 'package:world_cue/utils/constants.dart';
import 'package:world_cue/utils/shared_pref.dart';
import 'package:world_cue/view/common_widgets/toast.dart';
import 'package:world_cue/view/screens/login_screen.dart';

class HomeController extends GetxController {
  final NewsRepository _newsRepo = NewsRepository();
  final NewsSummarizerService _summarizer = NewsSummarizerService();

  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxString currentCategory = 'general'.obs;
  final RxString currentQuery = ''.obs;
  final RxSet<String> bookmarkedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved bookmarks from SharedPref
    final saved = SharedPref.getList(SharedPrefConstants.bookMarkIdList);
    if (saved != null) {
      bookmarkedIds.addAll(saved.map((e) => e.toString()));
    }
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

  /// Refresh headlines (reset pagination)
  Future<void> refreshNews() async {
    hasMore.value = true;
    await fetchNews(page: 1, category: currentCategory.value);
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
    return await _summarizer.getNewsShortSummary(
      sourceLink: news.sourceLink,
      newsText: news.description,
      title: news.title,
    );
  }

  Future<String> summarizeNewsLong(NewsModel news) async {
    return await _summarizer.getNewsDetailedSummary(
      sourceLink: news.sourceLink,
      newsText: news.description,
      title: news.title,
      // isLong: true
    );
  }

  Future<void> bookmarkNews(NewsModel news) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(SharedPref.getString(SharedPrefConstants.userId))
          .collection("bookmarks")
          .doc(news.id);

      await ref.set(news.toJson(), SetOptions(merge: true));

      bookmarkedIds.add(news.id);

      SharedPref.setOrAppendList(
        SharedPrefConstants.bookMarkIdList,
        bookmarkedIds.toList(),
      );
    } catch (error) {
      showErrorToast("Failed to add bookmark: $error");
    }
  }

  Future<void> removeBookmark(NewsModel news) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(SharedPref.getString(SharedPrefConstants.userId))
          .collection("bookmarks")
          .doc(news.id);

      await ref.delete();

      bookmarkedIds.remove(news.id);

      SharedPref.setOrAppendList(
        SharedPrefConstants.bookMarkIdList,
        bookmarkedIds.toList(),
      );
    } catch (error) {
      showErrorToast("Failed to remove bookmark: $error");
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      await SharedPref.deleteAll();
      Get.to(() => LoginScreen());
    } catch (e) {
      showErrorToast('Logout failed: $e');
    }
  }
}
