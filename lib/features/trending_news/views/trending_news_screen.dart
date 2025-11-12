import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/features/news/view/news_screen.dart';
import 'package:world_cue/features/news/view/search_card.dart';
import 'package:world_cue/features/trending_news/controller/trending_news_controller.dart';
import 'package:world_cue/generated/l10n.dart';

class TrendingNewsScreen extends StatelessWidget {
  final String topic;

  TrendingNewsScreen({super.key, required this.topic});

  late final TrendingNewsController controller = Get.put(TrendingNewsController(topic: topic));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: topic,
          child: Text(topic, style: context.titleBoldStyle),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isInitialLoading) {
                // Only show centered loader if first page (news list empty)
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (controller.newsList.isEmpty && controller.isSearching.value) {
                return Center(
                  child: Text(
                    S.of(context).noNewsFound,
                    style: context.bodyMediumStyle,
                  ),
                );
              }

              if (controller.newsList.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).typeSomethingToGetResults,
                    style: context.bodyMediumStyle,
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                    // within 200px from bottom
                    controller.loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: controller.newsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.newsList.length) {
                      if (controller.isLoading.value &&
                          controller.newsList.isNotEmpty) {
                        // ✅ show small loader below list for pagination
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox(height: 80); // space at bottom
                      }
                    }

                    final news = controller.newsList[index];
                    return Hero(
                      tag: index,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  NewsScreen(news: controller.newsList[index]),
                            ),
                          );
                        },
                        child: SearchCard(model: news),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
