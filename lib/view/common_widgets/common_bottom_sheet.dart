import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/utils/navigation.dart';
import 'package:world_cue/utils/size_config.dart';

import 'padding_helper.dart';

void commonBottomSheet(BuildContext context,
    {bool isScrollable = false,
    required Widget content,
    double? height,
    bool hideCloseIcon = false,
    bool isDismissible = true}) {
  showModalBottomSheet(
    isScrollControlled: isScrollable,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    elevation: 0,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          hideCloseIcon
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    backToPrevious(context);
                  },
                  child: Padding(
                    padding: padOnly(right: 8),
                    child: const Icon(Icons.clear),
                  ),
                ),
          boxH8(),
          Container(
            padding: padAll(value: 16.sp),
            width: screenWidth(),
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.all(Radius.circular(24.sp)),
            ),
            child: content,
          )
        ],
      );
    },
  );
}
