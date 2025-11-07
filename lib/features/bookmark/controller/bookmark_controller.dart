import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/utils/constants.dart';
import 'package:world_cue/core/widgets/toast.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class BookmarkController extends GetxController {
  final RxList<NewsModel> bookmarkedNewsList = <NewsModel>[].obs;
  final RxSet<String> bookmarkedIds = <String>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarkedIds();
    fetchBookmarks();
  }

  void _loadBookmarkedIds() {
    final saved = SharedPref.getList(SharedPrefConstants.bookMarkIdList);
    if (saved != null) {
      bookmarkedIds.clear();
      bookmarkedIds.addAll(saved.map((e) => e.toString()));
    }
  }

  /// Fetch all bookmarks from Firestore
  Future<void> fetchBookmarks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = SharedPref.getString(SharedPrefConstants.userId);
      if (userId == null || userId.isEmpty) {
        errorMessage.value = "User not logged in.";
        return;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('bookmarks')
          .get();

      final bookmarks = snapshot.docs.map((doc) {
        return NewsModel.fromJson(doc.data());
      }).toList();

      bookmarkedNewsList.assignAll(bookmarks);
      bookmarkedIds.clear();
      bookmarkedIds.addAll(bookmarks.map((b) => b.id));
    } catch (e) {
      errorMessage.value = "Failed to load bookmarks: $e";
    } finally {
      isLoading.value = false;
    }
  }

  /// Add bookmark
  Future<void> bookmarkNews(NewsModel news) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(SharedPref.getString(SharedPrefConstants.userId))
          .collection("bookmarks")
          .doc(news.id);

      await ref.set(news.toJson(), SetOptions(merge: true));

      bookmarkedIds.add(news.id);
      bookmarkedNewsList.add(news);

      SharedPref.setOrAppendList(
        SharedPrefConstants.bookMarkIdList,
        bookmarkedIds.toList(),
      );
    } catch (error) {
      showErrorToast("Failed to add bookmark: $error");
    }
  }

  /// Remove bookmark
  Future<void> removeBookmark(NewsModel news) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(SharedPref.getString(SharedPrefConstants.userId))
          .collection("bookmarks")
          .doc(news.id);

      await ref.delete();

      bookmarkedIds.remove(news.id);
      bookmarkedNewsList.removeWhere((b) => b.id == news.id);

      SharedPref.setOrAppendList(
        SharedPrefConstants.bookMarkIdList,
        bookmarkedIds.toList(),
      );
    } catch (error) {
      showErrorToast("Failed to remove bookmark: $error");
    }
  }
}
