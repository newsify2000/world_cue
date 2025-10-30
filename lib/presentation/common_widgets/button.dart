import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/app.dart';

import 'padding_helper.dart';

Widget buildButton(String text,
    {required VoidCallback onPressed,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor}) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: padding ?? padAll(),
            backgroundColor: backgroundColor ??
                Theme.of(navigatorKey.currentContext!).colorScheme.primary,
            shape: RoundedRectangleBorder(
                side: borderColor != null
                    ? BorderSide(color: borderColor)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(8.sp)),
          ),
          child: Text(text,
              style: textStyle ??
                  AppTextTheme.subtitleBoldStyle.copyWith(
                      color: textColor ??
                          Theme.of(navigatorKey.currentContext!)
                              .colorScheme
                              .onPrimary)),
        ),
      ),
    ],
  );
}

Widget buildGradientButton(BuildContext context, String text,
    {required VoidCallback onPressed,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    List<Color>? colors,
    Color? borderColor,
    IconData? icon,
    Color? iconColor}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: colors ??
                  [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
            ),
            borderRadius: BorderRadius.circular(8.sp),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: padding ?? padAll(),
              backgroundColor: Colors.transparent,
              // Important for gradient to show
              shadowColor: Colors.transparent,
              // Remove shadow if gradient is used
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: iconColor ??
                        textColor ??
                        Theme.of(navigatorKey.currentContext!)
                            .colorScheme
                            .onPrimary,
                    size: 20.sp, // Adjust size as needed
                  ),
                if (icon != null) SizedBox(width: 8.w),
                // Spacing between icon and text
                Text(text,
                    style: textStyle ??
                        AppTextTheme.subtitleBoldStyle.copyWith(
                            color: textColor ??
                                Theme.of(navigatorKey.currentContext!)
                                    .colorScheme
                                    .onPrimary)),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
