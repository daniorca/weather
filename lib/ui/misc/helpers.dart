import 'package:flutter/material.dart';
import 'dart:math' as math;

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
