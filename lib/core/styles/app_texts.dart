import 'package:flutter/material.dart';
import '../utils/app_fonts.dart';

class AppTexts {
  const AppTexts({
    required this.data,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textDecoration,
    this.lineHeight,
  });

  final String data;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final double? lineHeight;

  Text _font(
      BuildContext context, {
        required FontWeight fontWeight,
        required double fontSize,
        Color? color,
        double? height,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: AppFonts.appFontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ??
            (isDark
                ? theme.textTheme.bodyLarge?.color ?? Colors.white
                : theme.textTheme.bodyLarge?.color ?? Colors.black),
        height: height,
        decoration: textDecoration,
      ),
    );
  }

  // === أنواع النصوص ===

  Text Bold20(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.bold,
      fontSize: 20,
      color: color,
    );
  }

  Text SemiBold20(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.semiBold,
      fontSize: 20,
      color: color,
    );
  }

  Text SemiBold16(BuildContext context, {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return _font(
      context,
      fontWeight: fontWeight ?? AppFonts.semiBold,
      fontSize: fontSize ?? 16,
      color: color,
    );
  }

  Text SemiBold14(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.semiBold,
      fontSize: 14,
      color: color,
    );
  }

  Text SemiBold12Grey(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.semiBold,
      fontSize: 12,
      color: color ?? Colors.grey,
    );
  }

  Text medium14(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.medium,
      fontSize: 14,
      color: color,
    );
  }

  Text medium16White(BuildContext context, {Color? color}) {
    return _font(
      context,
      fontWeight: AppFonts.medium,
      fontSize: 16,
      color: color ?? Colors.white,
    );
  }
}
