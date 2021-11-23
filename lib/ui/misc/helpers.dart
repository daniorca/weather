import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:weather_app/ui/widgets/app_icon_button.dart';

Widget slash(double height) => Transform.rotate(
      angle: math.pi / 12,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 1,
          height: height,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );

InputDecoration inputDecoration(String hintText, VoidCallback onPressed) =>
    InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(14),
      ),
      contentPadding: const EdgeInsets.only(left: 16, top: 14),
      border: InputBorder.none,
      hintText: hintText,
      suffixIcon: AppIconButton(
        icon: Icons.clear,
        onPressed: onPressed,
      ),
    );


BoxDecoration cardBoxDecoration({Color color = Colors.white12}) => BoxDecoration(
  color: color,
  borderRadius: BorderRadius.circular(20),
);