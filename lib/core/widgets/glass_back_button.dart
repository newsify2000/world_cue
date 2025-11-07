import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
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
              color: colorScheme.onPrimary.withAlpha(25), // ~10% opacity
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.onPrimary.withAlpha(204), // ~80% opacity
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: iconSize ?? 22.w,
            ),
          ),
        ),
      ),
    );
  }
}
