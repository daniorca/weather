import 'package:flutter/material.dart';

class AppText {
  static const FontWeight _regular = FontWeight.w300;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _demiBold = FontWeight.w600;

  static Text _title(String str, double size, FontWeight weight,
      double letterSpacing, double lineHeight, Color? color,
      {Key? key, TextAlign? textAlign, int? maxLines}) {
    return Text(
      str,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: letterSpacing,
          height: lineHeight / size,
          color: color),
    );
  }

  static Text title90m(String str, {Color? color}) =>
      _title(str, 90, _medium, 0, 94, color);
  
  static Text title60m(String str, {Color? color}) =>
      _title(str, 60, _medium, 0, 10, color);

  static Text body30r(String str, {Color? color}) =>
      _title(str, 30, _regular, 0, 40, color);

  static Text body24r(String str, {Color? color}) =>
      _title(str, 24, _regular, 0.4, 28, color);

  static Text body22r(String str, {Color? color}) =>
      _title(str, 22, _regular, 0, 32, color);
  
  static Text body20r(String str, {Color? color}) =>
      _title(str, 20, _regular, 0.4, 26, color);

  static Text body18r(String str, {Color? color}) =>
      _title(str, 18, _regular, 0.3, 24, color);

  static Text body15r(String str,
          {Color? color, TextAlign? textAlign, int? maxLines}) =>
      _title(str, 15, _regular, 0.3, 20, color,
          textAlign: textAlign, maxLines: maxLines);

  static Text body14r(String str, {Color? color}) =>
      _title(str, 14, _regular, 0.1, 20, color);

  static Text title30d(String str, {Color? color}) =>
      _title(str, 30, _demiBold, 0, 34, color);

  static Text body24d(String str, {Color? color}) =>
      _title(str, 24, _demiBold, 0.4, 28, color);

  static Text caption13r(String str, {Color? color}) =>
      _title(str, 13, _regular, 0.25, 16.9, color);

  static Text caption12r(String str, {Color? color}) =>
      _title(str, 12, _regular, 0.25, 16.9, color);
}
