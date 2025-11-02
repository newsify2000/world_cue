import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/view/common_widgets/custom_network_image.dart';
import 'package:world_cue/view/common_widgets/glass_back_button.dart';
import 'package:world_cue/controllers/home_controller.dart';
import 'package:world_cue/view/screens/news_screen.dart';
import 'package:world_cue/view/theme/text_style.dart';
import 'package:world_cue/utils/navigation.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';

class NewsItem extends StatefulWidget {
  final NewsModel news;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBookmarkTap;
  final bool showButtons;
  final IconData trailingIcon;
  final IconData leadingIcon;

  const NewsItem({
    super.key,
    required this.news,
    required this.trailingIcon,
    this.leadingIcon = Icons.view_sidebar_rounded,
    this.onMenuTap,
    this.onBookmarkTap,
    this.showButtons = false,
  });

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  String? summaryText;
  bool isLoading = true;

  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _generateSummary();
  }

  Future<void> _generateSummary() async {
    try {
      final summary = await controller.summarizeNews(widget.news);
      if (mounted) {
        setState(() {
          if (summary.isEmpty ||
              summary == "[ERROR_INVALID_CONTENT]" ||
              summary.startsWith("ERROR_FAILED_TO_GET_SUMMARY")) {
            summaryText = widget.news.description.isNotEmpty
                ? "${widget.news.description.split('...')[0]}..."
                : "No description available.";
          } else {
            summaryText = summary;
          }
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        summaryText = widget.news.description.isNotEmpty
            ? "${widget.news.description.split('...')[0]}..."
            : "No description available.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                width: screenWidth(),
                height: screenHeight(percentage: 55),
                imageUrl: news.imageLink,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        appColorScheme(context).primaryContainer,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        appColorScheme(context).primaryContainer,
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.showButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlassButton(
                      icon: widget.leadingIcon,
                      onTap: widget.onMenuTap,
                    ),
                    GlassButton(
                      icon: widget.trailingIcon,
                      onTap: widget.onBookmarkTap,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.w, vertical: 64.h),
            ],
          ),

          // Title
          GestureDetector(
            onTap: () {
              if (!isLoading) {
                moveTo(context, NewsScreen(news: news));
              }
            },
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextTheme.titleBoldStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
          ),

          // Description / Summary
          GestureDetector(
            onTap: () {
              if (!isLoading) {
                moveTo(context, NewsScreen(news: news));
              }
            },
            child: isLoading
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ).paddingOnly(right: 8.w),
                      Text(
                        "Generating AI summary ",
                        style: AppTextTheme.bodyStyle.copyWith(
                          color: appColorScheme(context).onPrimary,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ).paddingOnly(left: 16.w, right: 16.w, top: 16.h)
                : Text(
                    (summaryText ?? "No description available."),
                    style: AppTextTheme.bodyStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
          ),

          // Source + Date
          if (!isLoading)
            Text(
              news.publishedAt.isNotEmpty && news.sourceName.isNotEmpty
                  ? "${formatDateToDayMonth(news.publishedAt)} • ${news.sourceName}"
                  : "source info not available",
              style: AppTextTheme.captionStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: 16.w, top: 4.h),
        ],
      ),
    );
  }
}
