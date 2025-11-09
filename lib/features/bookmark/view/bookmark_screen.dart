import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/news_card.dart';
import 'package:world_cue/core/widgets/news_card_shimmer.dart';
import 'package:world_cue/features/bookmark/controller/bookmark_controller.dart';

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return NewsCardShimmer(showButtons: false);
        }
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

        if (controller.bookmarkedNewsList.isEmpty) {
          return GestureDetector(
            onTap: () {
              controller.fetchBookmarks();
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("No bookmarks yet.", style: context.titleBoldStyle),
                  Text("Click to refresh.", style: context.bodyStyle),
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
