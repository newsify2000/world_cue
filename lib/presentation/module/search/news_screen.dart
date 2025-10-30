import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:world_cue/models/news_model.dart';

class NewsScreen extends StatefulWidget {
  final List<NewsModel> newsList;
  final int initialIndex;

  const NewsScreen({
    super.key,
    required this.newsList,
    required this.initialIndex,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          final model = widget.newsList[_currentIndex];
          // await launchUrl(Uri.parse(model.link));
        },
        child: Container(
          width: width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.blueGrey.shade900,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: const Text(
            "See Full Article",
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.newsList.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final model = widget.newsList[index];
          return _buildNewsPage(model, index, height, width);
        },
      ),
    );
  }

  Widget _buildNewsPage(
    NewsModel model,
    int index,
    double height,
    double width,
  ) {
    return SizedBox(
      height: height,
      width: width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.initialIndex == index ? index : '${index}_nonhero',
              child: Stack(
                children: [
                  ClipRRect(
                    child: SizedBox(
                      height: height / 2.75,
                      width: width,
                      child: CachedNetworkImage(
                        imageUrl: model.imageLink,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        placeholder:
                            (context, url) => Shimmer.fromColors(
                              baseColor: Colors.blueGrey.shade900,
                              highlightColor: Colors.white,
                              child: SizedBox(
                                height: height / 2.75,
                                width: width,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                      ),
                    ),
                  ),

                  SafeArea(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.blueGrey.shade900,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        // await launchUrl(Uri.parse(model.sourceLink));
                      },
                      child: Text("Source: ${model.sourceName}"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(thickness: 2, indent: 3, endIndent: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
