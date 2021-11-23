import 'package:flutter/material.dart';

class AppAsset {
  static const String backgroundImage = 'weather_bg.png';
  static const String mintemp = 'min_temp.png';
  static const String maxtemp = 'max_temp.png';
  static const String error = 'something_wrong.png';

  static Image image(
    String? name, {
    double? width,
    double? height
  }) =>
      Image.asset(
        'assets/images/$name',
        width: width,
        height: height
      );
}