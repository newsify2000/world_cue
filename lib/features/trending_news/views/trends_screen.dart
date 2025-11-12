import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/size_config.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/features/trending_news/controller/trends_controller.dart';
import 'package:world_cue/features/trending_news/views/trending_news_screen.dart';
import 'package:world_cue/generated/l10n.dart';

/// Screen to display the trending topics for India and Global.
class TrendsScreen extends StatelessWidget {
  final TrendsController controller = Get.find<TrendsController>();

  TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(S.of(context).trendingNow, style: context.titleBoldStyle),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).failedToFetchTrendingTopics),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.fetchTrendingTopics,
                  child: Text(
                    S.of(context).retry,
                    style: context.titleMediumStyle,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchTrendingTopics,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSection(
                context,
                S.of(context).trendingInIndia,
                controller.indiaTopics,
              ),
              boxH32(),
              _buildSection(
                context,
                S.of(context).trendingGlobally,
                controller.globalTopics,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<TopicItem> topics,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.titleBoldStyle),
        const SizedBox(height: 8),
        ...topics.map(
          (t) => Container(
            decoration: BoxDecoration(
              color: appColorScheme(
                context,
              ).onPrimaryContainer.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.to(() => TrendingNewsScreen(topic: t.topic)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://avatar.iran.liara.run/username?username=${t.topic}",
                  ),
                ),
                title: Hero(
                  tag: t.topic,
                  child: Text(t.topic, style: context.bodyBoldStyle),
                ),
                subtitle: Text(t.category, style: context.labelStyle),
              ),
            ),
          ).paddingOnly(bottom: 8.h),
        ),
      ],
    );
  }
}
