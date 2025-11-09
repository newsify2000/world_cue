import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/navigation/navigation.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/custom_network_image.dart';
import 'package:world_cue/core/widgets/glass_back_button.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/image_view/view/image_view.dart';
import 'package:world_cue/features/news/model/news_model.dart';
import 'package:world_cue/features/news/view/news_screen.dart';
import 'package:world_cue/generated/l10n.dart';

class NewsCard extends StatefulWidget {
  final NewsModel news;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBookmarkTap;
  final bool showButtons;
  final IconData trailingIcon;
  final IconData leadingIcon;

  const NewsCard({
    super.key,
    required this.news,
    required this.trailingIcon,
    this.leadingIcon = Icons.view_sidebar_rounded,
    this.onMenuTap,
    this.onBookmarkTap,
    this.showButtons = false,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () => moveTo(context, ImageView(news: news)),
                child: Hero(
                  tag: news.image,
                  child: CustomNetworkImage(
                    width: screenWidth(),
                    height: screenHeight(percentage: 55),
                    imageUrl: news.image,
                  ),
                ),
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
                  height: 30.h,
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
            onTap: () => moveTo(context, NewsScreen(news: news)),
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.titleBoldStyle,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
          ),

          // Description / Summary
          GestureDetector(
            onTap: () => moveTo(context, NewsScreen(news: news)),
            child: Text(
              (news.summary),
              style: context.bodyStyle,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
          ),

          // Source + Date
          Text(
            news.publishedAt != S.of(context).notavailable &&
                    news.source.name != S.of(context).unknownsource
                ? "${formatDateToDayMonth(news.publishedAt)} • ${news.source.name}"
                : S.of(context).sourceInfoNotAvailable,
            style: context.captionStyle,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ).paddingOnly(left: 16.w, top: 4.h),
        ],
      ),
    );
  }
}
