import 'package:flutter/material.dart';
import '../utils/app_fonts.dart';

class AppTexts {
  const AppTexts({
    required this.data,
    this.textColor = Colors.black,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textDecoration,
    this.lineHeight,
  });

  final String data;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final double? lineHeight;

  Text _font({
    required String fontFamily,
    required FontWeight fontWeight,
    required double fontSize,
    Color? color,
    double? height,
  }) {
    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
        decoration: textDecoration,
      ),
    );
  }

  /// Example Fonts for Manrope:
  Text manropeBold20({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.bold,
      fontSize: 20,
      color: color ?? const Color.fromRGBO(31, 31, 31, 1),
      height: 1.0, // lineHeight 20pt ≈ 1.0
    );
  }

  Text SemiBold14({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.semiBold,
      fontSize: 14,
      color: color ?? const Color.fromRGBO(0, 0, 0, 1),
    );
  }
  Text medium14({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.medium,
      fontSize: 14,
      color: color ?? const Color.fromRGBO(0, 0, 0, 1),
    );
  }
  Text medium16White({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.medium,
      fontSize: 16,
      color: color ?? const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  Text SemiBold12Grey({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.semiBold,
      fontSize: 12,
      color: color ?? const Color.fromRGBO(31, 31, 31, 0.48),
    );
  }
  Text SemiBold16({Color? color, double? fontSize,FontWeight ? fontWeight}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: fontWeight ?? AppFonts.semiBold,
      fontSize: fontSize ?? 16,
      color: color ?? const Color.fromRGBO(31, 31, 31, 1),
    );
  }

  Text Bold20({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.bold,
      fontSize: 20,
      color: color ?? const Color.fromRGBO(31, 31, 31, 1),
    );
  }
  Text SemiBold20({Color? color}) {
    return _font(
      fontFamily: AppFonts.appFontFamily,
      fontWeight: AppFonts.semiBold,
      fontSize: 20,
      color: color ?? const Color.fromRGBO(31, 31, 31, 1),
    );
  }
}
