import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:world_cue/models/news_model.dart';
import 'package:world_cue/view/common_widgets/custom_network_image.dart';
import 'package:world_cue/view/theme/text_style.dart';
import 'package:world_cue/utils/utilities.dart';

class SearchItem extends StatelessWidget {
  final NewsModel model;

  const SearchItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
            imageUrl: model.imageLink,
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
                  style: AppTextTheme.bodyBoldStyle.copyWith(
                    color: appColorScheme(context).onPrimary,
                  ),
                ),
                Text(
                  model.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.bodyStyle.copyWith(
                    color: appColorScheme(context).onPrimary,
                  ),
                ),
                Text(
                  formatTime(model.publishedAt),
                  overflow: TextOverflow.ellipsis,
                  style: AppTextTheme.captionStyle.copyWith(
                    color: appColorScheme(context).onPrimary,
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 8.h, horizontal: 16.w),
          ),
        ],
      ),
    );
  }
}
