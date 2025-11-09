import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class ImageView extends StatefulWidget {
  final NewsModel news;

  const ImageView({super.key, required this.news});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool _showSummary = true;

  void _onHoldStart(_) {
    setState(() {
      _showSummary = false;
    });
  }

  void _onHoldEnd(_) {
    setState(() {
      _showSummary = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.news.image;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.news.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleBoldStyle.copyWith(color: Colors.white),
        ).paddingOnly(right: 48.w),
      ),
      body: Stack(
        children: [
          // ✅ Pro zoomable image
          GestureDetector(
            onLongPressStart: _onHoldStart,
            onLongPressEnd: _onHoldEnd,
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3.5,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
            ),
          ),

          // ✅ Glassy summary box at bottom
          if (_showSummary)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Text(
                      widget.news.content,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMediumStyle.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
