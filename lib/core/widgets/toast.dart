import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/app.dart';
import 'package:world_cue/core/theme/text_style.dart';

void showErrorToast(String message) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
    builder: (context) => ToastCard(
      color: Theme.of(context).colorScheme.error,
      leading: Icon(
        Icons.error_outline,
        color: Theme.of(context).colorScheme.onError,
        size: ScreenUtil().setSp(24),
      ),
      trailing: InkWell(
        onTap: () {
          toastBar!.remove();
        },
        child: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.onError,
          size: ScreenUtil().setSp(24),
        ),
      ),
      title: Text(
        message,
        style: context.bodyStyle.copyWith(
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
  );
  toastBar.show(navigatorKey.currentContext!);
}

void showSuccessToast(String message) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
    builder: (context) => ToastCard(
      color: Colors.green,
      leading: Icon(
        Icons.error_outline,
        color: Theme.of(context).colorScheme.onError,
        size: ScreenUtil().setSp(24),
      ),
      trailing: InkWell(
        onTap: () {
          toastBar!.remove();
        },
        child: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.onError,
          size: ScreenUtil().setSp(24),
        ),
      ),
      title: Text(
        message,
        style: context.bodyStyle.copyWith(
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
  );
  toastBar.show(navigatorKey.currentContext!);
}

void toast(String message) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
    builder: (context) => ToastCard(
      leading: const Icon(Icons.emoji_emotions_rounded, size: 28),
      trailing: InkWell(
        onTap: () {
          toastBar!.remove();
        },
        child: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.onSecondary,
          size: ScreenUtil().setSp(24),
        ),
      ),
      title: Text(message, style: context.bodyStyle),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
  );
  toastBar.show(navigatorKey.currentContext!);
}

void toastWithAction(String message, VoidCallback action) {
  DelightToastBar? toastBar;

  toastBar = DelightToastBar(
    builder: (context) => ToastCard(
      trailing: InkWell(
        onTap: () {
          toastBar!.remove();
          action();
        },
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
          size: ScreenUtil().setSp(24),
        ),
      ),
      title: Text(message, style: context.bodyStyle),
    ),
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
  );
  toastBar.show(navigatorKey.currentContext!);
}
