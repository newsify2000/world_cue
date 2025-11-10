import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/news_card.dart';
import 'package:world_cue/core/widgets/news_card_shimmer.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;

  const HomeScreen({super.key, this.onOpenDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handlePageChange(int index) async {
    final shouldPreload =
        index >= controller.newsList.length - 3 &&
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
      body: Obx(() {
        // --- Initial Loading State ---
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return NewsCardShimmer(showButtons: true);
        }

        // --- Error State ---
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: context.bodyStyle.copyWith(
                color: appColorScheme(context).error,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        // --- Empty State ---
        if (controller.newsList.isEmpty) {
          return Center(child: Text(S.of(context).noNewsAvailable));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.refreshNews();
          },
          edgeOffset: 80,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // Prevent indicator when not on first page
              if (controller.pageController.page != 0) return false;
              return false;
            },
            child: PageView.builder(
              controller: controller.pageController,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              // ✅ required
              onPageChanged: _handlePageChange,
              itemCount: controller.newsList.length,
              itemBuilder: (context, i) {
                final news = controller.newsList[i];
                return controller.isLoading.value
                    ? NewsCardShimmer(showButtons: true)
                    : Obx(() {
                        final isBookmarked = controller.bookmarkedIds.contains(
                          news.id,
                        );
                        final bookmarkIcon = isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined;

                        return NewsCard(
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
            ),
          ),
        );
      }),
    );
  }
}
