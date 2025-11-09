import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/core/utils/utilities.dart';

class GlassButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final double? size;
  final double? iconSize;
  final Color? iconColor;

  const GlassButton({
    super.key,
    this.onTap,
    this.icon = Icons.arrow_back,
    this.size,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = size ?? 45.w;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(buttonSize / 2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: appColorScheme(context).onPrimary.withAlpha(25),
              shape: BoxShape.circle,
              border: Border.all(
                color: appColorScheme(context).onPrimary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor ?? appColorScheme(context).onPrimary.withValues(alpha: 0.5),
              size: iconSize ?? 22.w,
            ),
          ),
        ),
      ),
    );
  }
}
