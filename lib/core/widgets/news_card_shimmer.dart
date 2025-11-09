import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:shimmer/shimmer.dart';

class NewsCardShimmer extends StatelessWidget {
  final bool showButtons;

  const NewsCardShimmer({super.key, this.showButtons = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Placeholder ---
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              if (showButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _glassButtonPlaceholder(),
                    _glassButtonPlaceholder(),
                  ],
                ).paddingSymmetric(horizontal: 16.w, vertical: 64.h),
            ],
          ),

          // --- Title Placeholder ---
          Container(
            height: 20.h,
            width: MediaQuery.of(context).size.width * 0.85,
            margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          // --- Description Placeholder ---
          ...List.generate(
            3,
            (index) => Container(
              height: 14.h,
              width:
                  MediaQuery.of(context).size.width *
                  (index == 2 ? 0.6 : 0.9), // shorter last line
              margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),

          // --- Source + Date Placeholder ---
          Container(
            height: 12.h,
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(left: 16.w, top: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassButtonPlaceholder() {
    return Container(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade500.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
