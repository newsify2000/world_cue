import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:world_cue/generated/assets.dart';

import 'padding_helper.dart';

class LoadingDialog {
  static BuildContext? _context;
  static OverlayEntry? _overlayEntry;
  static late AnimationController _animationController;

  static void show(BuildContext context, {String message = 'Please Wait...'}) {
    _context = context;

    _animationController = AnimationController(
      vsync: Overlay.of(_context!),
      duration: const Duration(milliseconds: 300),
    );

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _buildOverlayContent(context, message),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(_context!).insert(_overlayEntry!);
      _animationController.forward();
    });
  }

  static void dismiss() {
    _animationController.reverse();
    Future.delayed(const Duration(milliseconds: 300), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  static Widget _buildOverlayContent(BuildContext context, String message) {
    return Stack(
      children: [
        // Background dim
        Positioned.fill(
          child: GestureDetector(
            onTap: dismiss,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.7, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: Container(
              padding: padAll(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Lottie.asset(
                Assets.assetsLoading,
                width: ScreenUtil().setSp(150),
                height: ScreenUtil().setSp(150),
                repeat: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
