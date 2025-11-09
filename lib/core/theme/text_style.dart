import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyles on BuildContext {
  Color get _textColor =>
      Theme.of(this).brightness == Brightness.dark ? Colors.white : Colors.black;

  // Display
  TextStyle get displayBoldStyle => GoogleFonts.urbanist(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get displayMediumStyle => GoogleFonts.urbanist(
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get displayStyle => GoogleFonts.urbanist(
    fontSize: 32.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Heading
  TextStyle get headingBoldStyle => GoogleFonts.urbanist(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get headingMediumStyle => GoogleFonts.urbanist(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get headingStyle => GoogleFonts.urbanist(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Subheading
  TextStyle get subHeadingBoldStyle => GoogleFonts.urbanist(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get subHeadingMediumStyle => GoogleFonts.urbanist(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get subHeadingStyle => GoogleFonts.urbanist(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Title
  TextStyle get titleBoldStyle => GoogleFonts.urbanist(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get titleMediumStyle => GoogleFonts.urbanist(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get titleStyle => GoogleFonts.urbanist(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Subtitle
  TextStyle get subtitleBoldStyle => GoogleFonts.urbanist(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get subtitleMediumStyle => GoogleFonts.urbanist(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get subtitleStyle => GoogleFonts.urbanist(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Body
  TextStyle get bodyBoldStyle => GoogleFonts.urbanist(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get bodyMediumStyle => GoogleFonts.urbanist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get bodyStyle => GoogleFonts.urbanist(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Label
  TextStyle get labelBoldStyle => GoogleFonts.urbanist(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get labelMediumStyle => GoogleFonts.urbanist(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get labelStyle => GoogleFonts.urbanist(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );

  // Caption
  TextStyle get captionBoldStyle => GoogleFonts.urbanist(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: _textColor,
  );

  TextStyle get captionMediumStyle => GoogleFonts.urbanist(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: _textColor,
  );

  TextStyle get captionStyle => GoogleFonts.urbanist(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: _textColor,
  );
}
