import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';
import 'package:weather_app/ui/widgets/min_max_temp.dart';

class SelectedForecast extends ConsumerStatefulWidget {
  SelectedForecast({Key? key}) : super(key: key);

  @override
  _SelectedForecastState createState() => _SelectedForecastState();
}

class _SelectedForecastState extends ConsumerState<SelectedForecast> {
  WeatherOfDay? weather;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    weather = ref.watch(dayWeatherNotifierProvider);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: weather == null
          ? SizedBox()
          : _buildForecast(weather!, orientation, size),
    );
  }

  _buildForecast(WeatherOfDay weather, Orientation orientation, Size size) {
    final double imageSize = orientation == Orientation.portrait ? 125 : 100;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: orientation == Orientation.portrait
              ? double.infinity
              : size.width * .35,
          height: orientation == Orientation.portrait ? 350 : 200,
          decoration: cardBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .060),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      AppText.body24r(
                          DateFormat.EEEE().format(weather.applicableDate)),
                      SizedBox(height: 3),
                      AppText.body14r(weather.weatherStateName),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    orientation == Orientation.portrait
                        ? AppText.title90m(
                            '${weather.currentTemp.toStringAsFixed(0)}º')
                        : AppText.title60m(
                            '${weather.currentTemp.toStringAsFixed(0)}º')
                  ],
                ),
                Spacer(),
                MinMaxTemperature(
                  minTemp: weather.minTemp,
                  maxTemp: weather.maxTemp,
                  isSmall: false,
                ),
                SizedBox(height: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Divider(color: Colors.white.withOpacity(0.3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppText.caption13r('Humidity',
                            color: AppColor.lightWhite),
                        SizedBox(width: 1),
                        AppText.caption13r('Pressure',
                            color: AppColor.lightWhite),
                        SizedBox(width: 40),
                        AppText.caption13r('Wind', color: AppColor.lightWhite),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppText.body15r('${weather.humidity}%'),
                        AppText.body15r(
                            '${weather.airPressure.toStringAsFixed(0)} mbar'),
                        AppText.body15r(
                            '${weather.windSpeed.toStringAsFixed(0)} mp/h'),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -65,
          left: 20,
          child: AppAsset.image('${weather.weatherStateAbbr}.png',
              width: imageSize, height: imageSize),
        ),
      ],
    );
  }
}
