import 'package:flutter/material.dart';

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

String formatTime(String isoDateString) {
  DateTime postDate = DateTime.parse(isoDateString).toLocal();
  Duration diff = DateTime.now().difference(postDate);

  if (diff.inSeconds < 60) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} hr ago';
  if (diff.inDays == 1) return 'Yesterday';
  if (diff.inDays < 7) return '${diff.inDays} days ago';
  if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} w ago';
  if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} mo ago';
  return '${(diff.inDays / 365).floor()} yr ago';
}
