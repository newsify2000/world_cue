import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/presentation/common_widgets/custom_network_image.dart';
import 'package:world_cue/presentation/module/home/controller/home_controller.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';
import 'package:world_cue/utils/utilities.dart';

class NewsScreen extends StatefulWidget {
  final NewsModel news;
  final VoidCallback? onBookmarkTap;

  const NewsScreen({super.key, required this.news, this.onBookmarkTap});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
      final summary = await controller.summarizeNewsLong(widget.news);
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
              imageUrl: news.imageLink,
              fit: BoxFit.contain,
            ),

            // Title
            Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextTheme.titleBoldStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),

            // Description / Summary
            Text(
              isLoading
                  ? "Generating AI summary..."
                  : (summaryText ?? "No description available."),
              style: AppTextTheme.bodyStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),

            // Source + Date
            Text(
              news.publishedAt.isNotEmpty && news.sourceName.isNotEmpty
                  ? "${formatDateToDayMonth(news.publishedAt)} • ${news.sourceName}"
                  : "source info not available",
              style: AppTextTheme.captionStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: 16.w, top: 4.h),
          ],
        ),
      ),
    );
  }
}
