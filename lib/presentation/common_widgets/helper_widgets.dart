import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget vector(String asset,
    {double? width, double? height, BoxFit fit = BoxFit.contain, Color? color}) {
  return SvgPicture.asset(
    asset,
    width: width,
    height: height,
    fit: fit,
    // ignore: deprecated_member_use
    color: color,
  );
}

Widget loadImage(
  String imageUrl, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return Image.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit,
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
          size: ScreenUtil().setSp(36),
        ),
      );
    },
  );
}
