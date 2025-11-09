import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/navigation/navigation.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/url_launcher.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/custom_network_image.dart';
import 'package:world_cue/features/home/controller/home_controller.dart';
import 'package:world_cue/features/image_view/view/image_view.dart';
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
        centerTitle: false,
        title: Text(
          news.title,
          maxLines: 1,
          style: context.titleBoldStyle,
        ).paddingOnly(right: 48.w),
      ),
      backgroundColor: appColorScheme(context).primaryContainer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: news.image,
              child: GestureDetector(
                onTap: () => moveTo(context, ImageView(news: news)),
                child: CustomNetworkImage(
                  width: screenWidth(),
                  imageUrl: news.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Title
            Text(
              news.title,
              style: context.titleBoldStyle,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
            Text(
              (news.content),
              style: context.bodyStyle,
              textAlign: TextAlign.justify,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),

            // Source + Date
            Row(
              children: [
                Text(
                  news.publishedAt != "NotAvailable" &&
                          news.source.name != "UnknownSource"
                      ? "${formatDateToDayMonth(news.publishedAt)} • ${news.source.name}"
                      : "source info not available",
                  style: context.captionStyle,
                ).paddingOnly(left: 16.w, top: 4.h, bottom: 48.h, right: 8.w),
                GestureDetector(
                  onTap: () {
                    UrlLauncher.launchURL(news.url, context);
                  },
                  child: Text(
                    "View Full Article",
                    style: context.labelStyle.copyWith(
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
