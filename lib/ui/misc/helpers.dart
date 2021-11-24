import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
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

BoxDecoration cardBoxDecoration({Color color = Colors.white12}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    );

BoxDecoration get gradientDecoration => BoxDecoration(
      gradient: LinearGradient(
          colors: AppColor.bgGradient,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    );

BorderRadius borderRadiusTop(double radius) {
  return BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );
}

Widget get verticalSeparator => Container(
      margin: EdgeInsets.only(left: 10, right: 20),
      color: AppColor.lightWhite,
      width: .5,
      height: 40,
    );

double convertToFahrenheit(double celsius) => (celsius * 1.8) + 32;

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => Material(
        child: const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue))),
      ),
      error: (e, _) => SizedBox.shrink(),
    );
  }
}
