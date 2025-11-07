import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/url_launcher.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/custom_network_image.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class NewsScreen extends StatefulWidget {
  final NewsModel news;
  final VoidCallback? onBookmarkTap;

  const NewsScreen({super.key, required this.news, this.onBookmarkTap});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColorScheme(context).primaryContainer,
        iconTheme: IconThemeData(color: appColorScheme(context).onPrimary),
        centerTitle: false,
        title: Text(
          news.title,
          maxLines: 1,
          style: AppTextTheme.titleBoldStyle.copyWith(
            color: appColorScheme(context).onPrimary,
          ),
        ).paddingOnly(right: 48.w),
      ),
      backgroundColor: appColorScheme(context).primaryContainer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              width: screenWidth(),
              imageUrl: news.image,
              fit: BoxFit.contain,
            ),

            // Title
            Text(
              news.title,
              style: AppTextTheme.titleBoldStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
            Text(
              (news.content),
              style: AppTextTheme.bodyStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
              textAlign: TextAlign.justify,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),

            // Source + Date
            Row(
              children: [
                Text(
                  news.publishedAt != "NotAvailable" && news.source.name != "UnknownSource"
                      ? "${formatDateToDayMonth(news.publishedAt)} • ${news.source.name}"
                      : "source info not available",
                  style: AppTextTheme.captionStyle.copyWith(
                    color: appColorScheme(context).onPrimary,
                  ),
                ).paddingOnly(left: 16.w, top: 4.h, bottom: 48.h, right: 8.w),
                GestureDetector(
                  onTap: () {
                    UrlLauncher.launchURL(news.url, context);
                  },
                  child: Text(
                    "View Full Article",
                    style: AppTextTheme.labelStyle.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ).paddingOnly(top: 4.h, bottom: 48.h),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
