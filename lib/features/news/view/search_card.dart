import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/core/theme/text_style.dart';
import 'package:world_cue/core/utils/utilities.dart';
import 'package:world_cue/core/widgets/custom_network_image.dart';
import 'package:world_cue/features/news/model/news_model.dart';

class SearchCard extends StatelessWidget {
  final NewsModel model;

  const SearchCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: appColorScheme(context).onPrimaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: appColorScheme(context).primaryContainer.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: model.image,
            width: 80.w,
            height: 120.h,
            fit: BoxFit.fitHeight,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyBoldStyle,
                ),
                Text(
                  model.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyStyle,
                ),
                Text(
                  formatTime(model.publishedAt),
                  overflow: TextOverflow.ellipsis,
                  style: context.captionStyle,
                ),
              ],
            ).paddingSymmetric(vertical: 8.h, horizontal: 16.w),
          ),
        ],
      ),
    );
  }
}
