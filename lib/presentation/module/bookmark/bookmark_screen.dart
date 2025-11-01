import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_cue/presentation/module/bookmark/bookmark_controller.dart';
import 'package:world_cue/presentation/module/home/widgets/news_item.dart';
import 'package:world_cue/presentation/module/home/widgets/news_item_shimmer.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/utilities.dart';

class BookmarkScreen extends StatefulWidget {
  final VoidCallback? onBackClick;

  const BookmarkScreen({super.key, this.onBackClick});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final BookmarkController controller = Get.put(BookmarkController());
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorScheme(context).primaryContainer,
      body: Obx(() {
        if (controller.isLoading.value) {
          return NewsItemShimmer(showButtons: false);
        }
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

        if (controller.bookmarkedNewsList.isEmpty) {
          return GestureDetector(
            onTap: () {
              controller.fetchBookmarks();
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No bookmarks yet.",
                    style: AppTextTheme.titleBoldStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
                  ),
                  Text(
                    "Click to refresh.",
                    style: AppTextTheme.bodyStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchBookmarks,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: controller.bookmarkedNewsList.length,
            itemBuilder: (context, i) {
              final news = controller.bookmarkedNewsList[i];
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
                        onMenuTap: widget.onBackClick,
                        leadingIcon: Icons.arrow_back_ios_new_rounded,
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
        );
      }),
    );
  }
}
