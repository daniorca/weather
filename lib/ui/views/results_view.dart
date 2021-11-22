import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/consolidated_weather_notifier.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/misc/helpers.dart';

class ResultsView extends ConsumerWidget {
  final Weather weather;
  const ResultsView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(consolidatedNotifierProvider.notifier).setConsolidatedWeather(weather.consolidatedWeather.first);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    weather.cityName.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weather.country,
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SelectedForecast(),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 150,
              child: ListView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                children: [
                  ...weather.consolidatedWeather.map(
                    (e) => GestureDetector(
                      onTap: () => ref.read(consolidatedNotifierProvider.notifier).setConsolidatedWeather(e),
                      child: Container(
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 150,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${DateFormat.E().format(e.applicableDate)}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppAsset.image(AppAsset.maxtemp,
                                              width: 8, height: 22),
                                          const SizedBox(width: 6),
                                          Text(
                                              '${e.maxTemp.toStringAsFixed(0)}º'),
                                          slash(20),
                                          AppAsset.image(AppAsset.mintemp,
                                              width: 8, height: 22),
                                          const SizedBox(width: 6),
                                          Text(
                                              '${e.minTemp.toStringAsFixed(0)}º'),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${DateFormat.yMd().format(e.applicableDate)}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.lightWhite),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -20,
                                  left: 15,
                                  child: AppAsset.image(
                                      '${e.weatherStateAbbr}.png',
                                      width: 90,
                                      height: 70),
                                )
                              ],
                            ),
                            const SizedBox(width: 18),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SelectedForecast extends ConsumerWidget {
  SelectedForecast({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ConsolidatedWeather? weather;
    final state = ref.watch(consolidatedNotifierProvider);
    if (state is ConsolidatedWeatherSelected) {
      weather = state.consolidatedWeather;
    }
    return weather != null ? Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
            bottom: 75,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AppAsset.image(AppAsset.maxtemp,
                                width: 10, height: 28),
                            const SizedBox(width: 10),
                            Text(
                                '${weather.maxTemp.toStringAsFixed(0)}º',
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Text('max')
                      ],
                    ),
                    slash(40),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AppAsset.image(AppAsset.mintemp,
                                width: 10, height: 28),
                            const SizedBox(width: 10),
                            Text(
                              '${weather.minTemp.toStringAsFixed(0)}º',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Text('min')
                      ],
                    )
                  ],
                ),
              ],
            )),
        Positioned(
          bottom: 16,
          left: 20,
          right: 20,
          child: Column(
            children: <Widget>[
              Divider(color: Colors.white.withOpacity(0.3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Humidity',
                      style: TextStyle(
                          fontSize: 13, color: AppColor.lightWhite)),
                  SizedBox(width: 1),
                  Text('Pressure',
                      style: TextStyle(
                          fontSize: 13, color: AppColor.lightWhite)),
                  SizedBox(width: 40),
                  Text('Wind',
                      style: TextStyle(
                          fontSize: 13, color: AppColor.lightWhite)),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${weather.humidity}%',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${weather.airPressure.toStringAsFixed(0)} mbar',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${weather.windSpeed.toStringAsFixed(0)} mp/h',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat.EEEE().format(
                    weather.applicableDate),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 5),
              Text(weather.weatherStateName),
            ],
          ),
        ),
        Positioned(
            top: 95,
            right: 35,
            child: Text(
                '${weather.currentTemp.toStringAsFixed(0)}º',
                style: TextStyle(fontSize: 96))),
        Positioned(
          top: -70,
          left: 16,
          child: AppAsset.image(
              '${weather.weatherStateAbbr}.png',
              width: 125,
              height: 125),
        ),
      ],
    ) : SizedBox();
  }
}
