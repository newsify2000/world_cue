import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_cue/controllers/home_controller.dart';
import 'package:world_cue/view/common_widgets/news_item.dart';
import 'package:world_cue/view/common_widgets/news_item_shimmer.dart';
import 'package:world_cue/view/theme/text_style.dart';
import 'package:world_cue/utils/utilities.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;

  const HomeScreen({super.key, this.onOpenDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  late final PageController _pageController;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    ever(controller.currentCategory, (_) {
      if (mounted && _pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handlePageChange(int index) async {
    // Preload next page when user reaches the second-last item
    final shouldPreload =
        index >= controller.newsList.length - 2 &&
        !_isFetchingMore &&
        !controller.isLoading.value;

    if (shouldPreload) {
      _isFetchingMore = true;
      await controller.fetchNews(page: controller.currentPage.value + 1);
      _isFetchingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorScheme(context).primaryContainer,
      body: Obx(() {
        // --- Initial Loading State ---
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return NewsItemShimmer(showButtons: true);
        }

        // --- Error State ---
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: AppTextTheme.bodyStyle.copyWith(
                color: appColorScheme(context).error,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        // --- Empty State ---
        if (controller.newsList.isEmpty) {
          return const Center(child: Text("No news available"));
        }

        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: _handlePageChange,
          itemCount: controller.newsList.length,
          itemBuilder: (context, i) {
            final news = controller.newsList[i];
            return controller.isLoading.value
                ? NewsItemShimmer(showButtons: true)
                : Obx(() {
                    final isBookmarked = controller.bookmarkedIds.contains(
                      news.id,
                    );
                    final bookmarkIcon = isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_add_outlined;
                    return NewsItem(
                      news: news,
                      onMenuTap: widget.onOpenDrawer,
                      trailingIcon: bookmarkIcon,
                      onBookmarkTap: () {
                        if (isBookmarked) {
                          controller.removeBookmark(news);
                        } else {
                          controller.bookmarkNews(news);
                        }
                      },
                      showButtons: true,
                    );
                  });
          },
        );
      }),
    );
  }
}
