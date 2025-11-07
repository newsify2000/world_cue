import 'package:flutter/material.dart';

EdgeInsets padAll({double value = 16}) {
  return EdgeInsets.all(value);
}

EdgeInsets padSym({double horizontal = 0, double vertical = 0}) {
  return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}

EdgeInsets padOnly({
  double top = 0,
  double right = 0,
  double bottom = 0,
  double left = 0,
}) {
  return EdgeInsets.only(top: top, right: right, bottom: bottom, left: left);
}
