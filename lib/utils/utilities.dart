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

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\d{10}$');
  return regex.hasMatch(phoneNumber);
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
