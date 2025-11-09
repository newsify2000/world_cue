import 'package:flutter/material.dart';
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

  if (diff.inSeconds < 60) return S.of(context).justNow;
  if (diff.inMinutes < 60) return S.of(context).diffinminutesMinAgo;
  if (diff.inHours < 24) return S.of(context).diffinhoursHrAgo;
  if (diff.inDays == 1) return S.of(context).yesterday;
  if (diff.inDays < 7) return S.of(context).diffindaysDaysAgo;
  if (diff.inDays < 30) return S.of(context).diffindays7floorWAgo;
  if (diff.inDays < 365) return S.of(context).diffindays30floorMoAgo;
  return S.of(context).diffindays365floorYrAgo;
}
