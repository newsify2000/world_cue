import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double screenHeight({double percentage = 100}) {
  return ScreenUtil().screenHeight * (percentage / 100);
}

double screenWidth({double percentage = 100}) {
  return ScreenUtil().screenWidth * (percentage / 100);
}

Widget boxW4() {
  return SizedBox(width: ScreenUtil().setWidth(4));
}

Widget boxW8() {
  return SizedBox(width: ScreenUtil().setWidth(8));
}

Widget boxW16() {
  return SizedBox(width: ScreenUtil().setWidth(16));
}

Widget boxW32() {
  return SizedBox(width: ScreenUtil().setWidth(32));
}

Widget boxW48() {
  return SizedBox(width: ScreenUtil().setWidth(48));
}

Widget boxWCustom(double width) {
  return SizedBox(width: ScreenUtil().setWidth(width));
}

Widget boxH4() {
  return SizedBox(height: ScreenUtil().setHeight(4));
}

Widget boxH8() {
  return SizedBox(height: ScreenUtil().setHeight(8));
}

Widget boxH16() {
  return SizedBox(height: ScreenUtil().setHeight(16));
}

Widget boxH32() {
  return SizedBox(height: ScreenUtil().setHeight(32));
}

Widget boxH48() {
  return SizedBox(height: ScreenUtil().setHeight(48));
}

Widget boxHCustom(double height) {
  return SizedBox(height: ScreenUtil().setHeight(height));
}
