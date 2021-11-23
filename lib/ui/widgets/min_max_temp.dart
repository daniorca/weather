import 'package:flutter/material.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';

class MinMaxTemperature extends StatelessWidget {
  final double maxTemp;
  final double minTemp;
  final bool isSmall;
  const MinMaxTemperature({
    Key? key,
    required this.maxTemp,
    required this.minTemp,
    this.isSmall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(isSmall ? 0.95 : 1.25),
      child: Row(
        mainAxisAlignment:
            isSmall ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          AppAsset.image(AppAsset.maxtemp, width: 8, height: 22),
          const SizedBox(width: 5),
          AppText.body14r('${maxTemp.toStringAsFixed(0)}°'),
          slash(20),
          AppAsset.image(AppAsset.mintemp, width: 8, height: 22),
          const SizedBox(width: 5),
          AppText.body14r('${minTemp.toStringAsFixed(0)}°'),
        ],
      ),
    );
  }
}
