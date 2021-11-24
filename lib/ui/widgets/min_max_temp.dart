import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';

class MinMaxTemperature extends ConsumerStatefulWidget {

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
  _MinMaxTemperatureState createState() => _MinMaxTemperatureState();
}

class _MinMaxTemperatureState extends ConsumerState<MinMaxTemperature> {

  double _maxTemperature = 0, _minTemperature = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tempNotifierProvider);
    calculateTemp(state);
    return Transform(
      transform: Matrix4.identity()..scale(widget.isSmall ? 0.95 : 1.25),
      child: Row(
        mainAxisAlignment:
            widget.isSmall ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          AppAsset.image(AppAsset.maxtemp, width: 8, height: 22),
          const SizedBox(width: 5),
          AppText.body14r('${_maxTemperature.toStringAsFixed(0)}°'),
          slash(20),
          AppAsset.image(AppAsset.mintemp, width: 8, height: 22),
          const SizedBox(width: 5),
          AppText.body14r('${_minTemperature.toStringAsFixed(0)}°'),
        ],
      ),
    );
  }

  void calculateTemp(bool isCelsius) {
    if (isCelsius) {
      _maxTemperature = widget.maxTemp;
      _minTemperature = widget.minTemp;
    } else {
      _maxTemperature = convertToFahrenheit(widget.maxTemp);
      _minTemperature = convertToFahrenheit(widget.minTemp);
    }
  }
}
