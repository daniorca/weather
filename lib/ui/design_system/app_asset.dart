import 'package:flutter/material.dart';

class AppAsset {
  static const String backgroundImage = 'weather_bg.png';

  static Image image(
    String? path, {
    Color? color,
    double? width,
    double? height,
    BoxFit? fit,
  }) =>
      Image.asset(
        'assets/images/$path',
        color: color,
        width: width,
        height: height,
        fit: fit,
      );

  static AssetImage imageAsset(String path) => AssetImage('assets/images/$path');
}