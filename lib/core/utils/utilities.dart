import 'package:flutter/material.dart';
import 'package:world_cue/core/utils/url_launcher.dart';
import 'package:world_cue/core/widgets/toast.dart';
import 'package:world_cue/generated/l10n.dart';

///Check if a value is null or not
extension NullCheck<T> on T {
  bool get isNull => this == null;
}

extension Separation on List<Widget> {
  ///add vertical gap between widgets
  List<Widget> separateVertically(double gap) {
    final separatedWidgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      separatedWidgets.add(this[i]);
      if (i < length - 1) {
        separatedWidgets.add(SizedBox(height: gap));
      }
    }

    return separatedWidgets;
  }

  ///add horizontal gap between widgets
  List<Widget> separateHorizontally(double gap) {
    final separatedWidgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      separatedWidgets.add(this[i]);
      if (i < length - 1) {
        separatedWidgets.add(SizedBox(width: gap));
      }
    }

    return separatedWidgets;
  }
}

String formatDateToDayMonth(String isoDate) {
  try {
    final dateTime = DateTime.parse(isoDate).toLocal();

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final day = dateTime.day;
    final month = months[dateTime.month - 1];

    return '$day $month';
  } catch (e) {
    return '';
  }
}

ColorScheme appColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

String formatTime(BuildContext context, String isoDateString) {
  DateTime postDate = DateTime.parse(isoDateString).toLocal();
  Duration diff = DateTime.now().difference(postDate);

  // Assuming 'diff' is a Duration object representing the time difference

  if (diff.inSeconds < 60) {
    return S.of(context).justNow;
  }

  if (diff.inMinutes < 60) {
    // Pass the calculated minutes value (diff.inMinutes) to the generated function
    return S.of(context).diffinminutesMinAgo(diff.inMinutes);
  }

  if (diff.inHours < 24) {
    // Pass the calculated hours value (diff.inHours)
    return S.of(context).diffinhoursHrAgo(diff.inHours);
  }

  if (diff.inDays == 1) {
    // Use 'yesterday' if the difference is exactly 1 day (no argument needed)
    return S.of(context).yesterday;
  }

  if (diff.inDays < 7) {
    // Pass the calculated days value (diff.inDays)
    return S.of(context).diffindaysDaysAgo(diff.inDays);
  }

  if (diff.inDays < 30) {
    // Calculate and pass the weeks value (diff.inDays / 7)
    final int weeks = (diff.inDays / 7).floor();
    return S.of(context).diffindays7floorWAgo(weeks);
  }

  if (diff.inDays < 365) {
    // Calculate and pass the months value (diff.inDays / 30)
    final int months = (diff.inDays / 30).floor();
    return S.of(context).diffindays30floorMoAgo(months);
  }

  // Default case: Years
  // Calculate and pass the years value (diff.inDays / 365)
  final int years = (diff.inDays / 365).floor();
  return S.of(context).diffindays365floorYrAgo(years);
}

void openAppInStore(BuildContext context) async {
  const url = "https://play.google.com/store/apps/details?id=com.worldcue.app";
  UrlLauncher.urlLauncher(url, context);
}

void openPrivacyPolicy(BuildContext context) async {
  const url = "https://www.worldcue.news/privacy-policy";
  UrlLauncher.urlLauncher(url, context);
}

void openTnC(BuildContext context) async {
  const url = "https://www.worldcue.news/terms-of-service";
  UrlLauncher.urlLauncher(url, context);
}

void shareAppLink() {
  toast("coming soon");
}
