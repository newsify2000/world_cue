import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/presentation/common_widgets/padding_helper.dart';
import 'package:world_cue/presentation/module/search/news_screen.dart';
import 'package:world_cue/presentation/module/search/news_search_controller.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/utilities.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NewsSearchController controller = Get.find<NewsSearchController>();
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();

    _focusNode.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            margin: padAll(value: 24.w),
            height: 56.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: appColorScheme(context).onSecondaryContainer,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: TextFormField(
              focusNode: _focusNode,
              controller: searchTextController,
              textInputAction: TextInputAction.search,
              onChanged: (value) async {
                if (value.trim().length >= 3) {
                  await controller.searchNews(page: 1, query: value.trim());
                } else {
                  controller.clearSearch();
                }
              },
              style: AppTextTheme.titleMediumStyle.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: appColorScheme(context).onPrimary,
                ),
                hintText: "Search news...",
                hintStyle: AppTextTheme.subtitleStyle.copyWith(
                  color: appColorScheme(context).onPrimary,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
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
                return const Center(
                  child: Text("Search something to get started"),
                );
              }

              return ListView.builder(
                itemCount: controller.newsList.length,
                itemBuilder: (context, index) {
                  final news = controller.newsList[index];
                  return Hero(
                    tag: index,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewsScreen(
                              newsList: controller.newsList,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      child: SearchContainer(model: news),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ✅ Reuse your SearchContainer (unchanged)
class SearchContainer extends StatelessWidget {
  final NewsModel model;

  const SearchContainer({super.key, required this.model});

  String formatTime(String isoDateString) {
    DateTime postDate = DateTime.parse(isoDateString).toLocal();
    Duration diff = DateTime.now().difference(postDate);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    }
    if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() > 1 ? 's' : ''} ago';
    }
    if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() > 1 ? 's' : ''} ago';
    }

    return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() > 1 ? 's' : ''} ago';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(11.5),
              ),
              child: Container(
                height: 80,
                width: width / 4.5,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  border: const Border(right: BorderSide(color: Colors.black)),
                ),
                child: CachedNetworkImage(
                  imageUrl: model.imageLink,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.blueGrey.shade900,
                    highlightColor: Colors.white,
                    child: Container(height: 80, width: width),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatTime(model.publishedAt),
                      style: GoogleFonts.merriweather(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
