import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/view/common_widgets/padding_helper.dart';
import 'package:world_cue/view/screens/news_screen.dart';
import 'package:world_cue/controllers/news_search_controller.dart';
import 'package:world_cue/view/common_widgets/search_item.dart';
import 'package:world_cue/view/theme/text_style.dart';
import 'package:world_cue/utils/utilities.dart';

class NewsSearchScreen extends StatelessWidget {
  NewsSearchScreen({super.key});

  final NewsSearchController controller = Get.put(NewsSearchController());
  final TextEditingController searchTextController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  void _onSearchChanged(String value) {
    controller.onSearchChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });

    return Scaffold(
      backgroundColor: appColorScheme(context).primaryContainer,
      appBar: AppBar(
        backgroundColor: appColorScheme(context).primaryContainer,
        iconTheme: IconThemeData(color: appColorScheme(context).onPrimary),
        title: Text(
          "Search News",
          style: AppTextTheme.titleBoldStyle.copyWith(
            color: appColorScheme(context).onPrimary,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: padOnly(left: 16.w, right: 16.w, bottom: 16.h),
            height: 52.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: appColorScheme(context).onSecondaryContainer,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Obx(() {
              return TextFormField(
                focusNode: focusNode,
                controller: searchTextController,
                textInputAction: TextInputAction.search,
                textAlignVertical: TextAlignVertical.center,
                style: AppTextTheme.titleBoldStyle.copyWith(
                  color: appColorScheme(context).onPrimary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12.w,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: appColorScheme(context).onPrimary,
                    size: 24.w,
                  ).paddingOnly(top: 2.h),
                  suffixIcon: controller.currentQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            searchTextController.clear();
                            controller.clearSearch();
                          },
                          child: Icon(
                            Icons.clear_rounded,
                            color: appColorScheme(context).onPrimary,
                            size: 24.w,
                          ).paddingOnly(top: 2.h, right: 4.w),
                        )
                      : null,
                  hintText: "Search news...",
                  hintStyle: AppTextTheme.subtitleStyle.copyWith(
                    color: appColorScheme(context).onPrimary,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isInitialLoading) {
                // Only show centered loader if first page (news list empty)
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (controller.newsList.isEmpty && controller.isSearching.value) {
                return const Center(
                  child: Text("No news found.", style: TextStyle(fontSize: 16)),
                );
              }

              if (controller.newsList.isEmpty) {
                return Center(
                  child: Text(
                    "Type something to get results...",
                    style: AppTextTheme.titleStyle.copyWith(
                      color: appColorScheme(context).onPrimary,
                    ),
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
                        child: SearchItem(model: news),
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
