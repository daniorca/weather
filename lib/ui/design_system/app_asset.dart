import 'package:flutter/material.dart';

class AppAsset {
  static const String backgroundImage = 'weather_bg.png';
  static const String clear = 'c.png';
  static const String hail = 'h.png';
  static const String heavycloud = 'hc.png';
  static const String lightcloud = 'lc.png';
  static const String heavyrain = 'hr.png';
  static const String lightrain = 'lrn.png';
  static const String sleet = 'sl.png';
  static const String snow = 'sn.png';
  static const String thunderstorm = 't.png';
  static const String mintemp = 'min_temp.png';
  static const String maxtemp = 'max_temp.png';


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